Return-Path: <linux-kernel+bounces-382781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25D9B1364
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C25B21E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182C212163;
	Fri, 25 Oct 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyQDF2nJ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684A217F31
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729899886; cv=none; b=qhtxbLnJN3hHL++z7UL14iXZ/YyT6vLw9gDhcclM3yE8fnRTKGjpuMLypgjr7Ki6ETHZmlvVuhZ9X1NDWaB6Qn1HBCzXUl9V6mDN0A6X0Q/Bv9pqyANce0oxzAoN+rR1P39/M1BhkLQA5YDbX+g4C1TwnrFGj6meS8HmouoqTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729899886; c=relaxed/simple;
	bh=cdygbOU2VbTNPSDdD6NixXxdT0gSIRvfesa+VGhMJ5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9jwSFptt50oDL2dlehOuhOTdbcVTPzsIcvtNXvIZTun7I7jTRtGAXG9E/2vDn/QqTGAn/69JlQtsFN5hpHsP7BYH9vOcftYWkaHV6skB/SozDvIAUaQ4ftpW8HJ0zG6CZbE0j6pk45AwyHu/IiDEtONkMqxeDJ1TCtZakUYttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyQDF2nJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so24044965e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729899882; x=1730504682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdygbOU2VbTNPSDdD6NixXxdT0gSIRvfesa+VGhMJ5U=;
        b=VyQDF2nJ+8QYLYHTIHR5IN5d/wHZlmpH+1PpW2L66o2nUgzyCeBRotfwTOjamGIEAQ
         OxWTlqYNQAoez8i+qaz+KcTSKPxCUs2P5Vt5uNWR2TmrybA7BWagJhq1PCJ1Gh0uVQUv
         blzOQec3+hV2y2ocTdmj6laYfLNYEhjqub3IXuESjMsX8a2yD8ujlqjcQtmWRbM+P8/T
         QdWimFl0LNYNLAxwGw4QyJI+tLW96AHBlWJQ48VAE443OSGwRmrM4HgFCSy1A8/J1goA
         17oxoXc6xUcu8zIXFgkyVXNUhbgMxH1Nhv4dESrJjmGdO81akMG9TRqe+xlLDQgvr/HZ
         tF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729899882; x=1730504682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdygbOU2VbTNPSDdD6NixXxdT0gSIRvfesa+VGhMJ5U=;
        b=MrlFQnzf5uZd/e+CCHeby7MBU0Z7cYAcTxzbx6ROCp74VJlSscS8d+IWr4vvcmqn6y
         DRq4D7apMsj2467QY+3ag2gStZlslRc1Ny+MwKGEIN5bNWoG1AMMCok8mVj2otBaBaFy
         yd0q10zY7ez2nce/ZYkLxMEGq84qXdwTCVp7UAUOmnYNLdcHcKt1lu1DgiPxgy+ItP5f
         RGodKq649EEABqcIrG/8xPUcKhi4mZjgUflUMzlu6w7+Q4V6zufX5f3cdCxq+xbw0F8U
         RaWSt+OpJEfdnukX0okXOgXpQp905lfNlrildHeu0e3g02wpoe4QI990Yrkarqwmvo8G
         vX9w==
X-Forwarded-Encrypted: i=1; AJvYcCUUrG4fyKQRMWIx8NvJ8s4qIaBEsNyW2UP9XddyEeKxvLSt40Q81lepNLhkAApfzY5N823vrM4v4Rst9Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwErRsBaduC7H9PHLN5fOAkom0tp6EBKa7RpLn6Wert2HPLXCm1
	8ZKGSnW3A6WNCbWMb9ysGQrHfpk/vxy6seP7MiaOlhhaFLTV5bYI
X-Google-Smtp-Source: AGHT+IGaryYRj64yhGrJAOKqBghsp1Jn0swXpkCrCwJX9nTbsNz1uigAXxLkxh4B5mOoEuWaSK6P+A==
X-Received: by 2002:a5d:4f92:0:b0:374:b35e:ea6c with SMTP id ffacd0b85a97d-380611dc6e9mr729391f8f.40.1729899881684;
        Fri, 25 Oct 2024 16:44:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:168:2000:d7:ee0d:9aff:fe84:bd6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bddbsm2760331f8f.27.2024.10.25.16.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 16:44:39 -0700 (PDT)
From: Vladimir Smirnov <civil.over@gmail.com>
To: mike@altlinux.org
Cc: contact@notyourfox.coffee,
	gregkh@linuxfoundation.org,
	james.bottomley@hansenpartnership.com,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various compliance requirements.
Date: Sat, 26 Oct 2024 01:44:35 +0200
Message-ID: <20241025234435.1006312-1-civil.over@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025114353.GA15332@imap.altlinux.org>
References: <20241025114353.GA15332@imap.altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A short disclaimer: opinions expressed are solely my own and not those
of my employer (hence I'm writing that from my personal email)

Misha, I know that after our last interaction you probably won't reply,
but I think it is useful for others to do a small fact-checking of your
reply here.

> There's another one: some lame duck's Executive Order 14071.

When you reference some EO - please quote it and give a link.

As if you go and read the document, you'll see that the invesments are
prohibited (and Maintainership is not an investment), approvals of
transactions (and again, not applicable) and that Secretary of the Treasure
have right to ban certain actions, like sales or reexportation. Again -
nothing directly applicable here.

> http://youtu.be/L5Ec5jrpLVk

I guess, that is the source of the "EO 14071" you've referenced, right?

Anyway, I actually would rephrase what I wrote in a different place exactly in
reply to someone bringing that video today:

There are several problems with that video:
1) Misleading title - you can clearly see that not all russian programmers were
banned by briefly checking MAINTAINERS file in its current state.
2) Maybe I don't know something, but Greg and Linus or CoC or Maintainers
handbook never mentions that removing from maintainers = ban. So that was
a mistake in the video.
3) About EO 14071 - I've quickly hinted to you that it is not what the video
says. To prove the point author then picks up an FAQ from OFAC about expanding
sanctions, which is completely different document and then underquote what it
says... If you scroll just a tiny bit further, you would see that FAQ
explicitly exclude opensource. If you don't belive me check for yourself:
https://ofac.treasury.gov/faqs/1185
Or if you don't trust FAQ, look at the original text: 31 CFR Part 587
And no, those are not sanctions that was known and just delayed until 2024,
but that is a minor problem in the video.
4) Video overall over exaggerate what happend. E.x. "Maintainer of CPU
Architecture" - you can easly get few messages back in the thread and
fact-check who was that and confirm that author is not entierly correct.
5) Even by the time video was published, it was easy to verify that the
whole thing related to OFAC SDN lists - it was a public knowledge that
affected people worked for companies on that list and even the wording itself
gives away what exactly that is (Greg's mention of documentation actually
only can mean it is related to relatively easily fixable problem) and later
Linus made it even clearer by saying something in line with "talk to your
company's lawayer" - which also confirms that.


So I would strongly suggest you to actually do a fact-checking of information
you consume and then spread, because if your opinion is based on false
statements, you probably will have disorted perspective on the matter.

> instead of diggin' their own grave as ordered
> by the most real nazis on this planet.

And that is a good example of what I've meant above. You should fact-check
before you call someone a nazi or even hint that, especially if in other cases
you've quoted low quality information (like the video above).

As there is almost 100% chance that if you'd did that - you won't be saying
what you were saying here or on the other thread within this discussion.

