Return-Path: <linux-kernel+bounces-572610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F8A6CC24
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DAE3A8D92
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4236235345;
	Sat, 22 Mar 2025 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="Bgm1m+1F"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E165233715
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742674345; cv=none; b=G5V87xZyIlReL4V132nd8PHUDOJBQdO3zWaokHFd4ZuCLAVEC9Yg/4WGmCyarWJw55M2TiuB5MqMBlXByqct/HL/ol3aD1/C89B4+y+pD3LdmxUrlZ4yCYdJn76UtWsFpD60vXVeuChEy0IH9eZ/ImOnXn29ZRTPjkkdmO/x0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742674345; c=relaxed/simple;
	bh=FyKkeKQ5wFneLXjBFFmhNdP7NtjNnMECbVyBDl05Z20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coDQ+coEpziljCOpILZAZQdKCZs0PkzdoPLrrwUk3VY57VNaKAeyAtFJWFwYipOUMMK3ETXCXwyKtOVc5X433Sx8rDOVetMm6TsUMJRuYGo6ZjilkRFwW24090njSpCgy4DJRga2ZXB6yHxP55CMuf9090Fcarru3aEUngWJFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=Bgm1m+1F; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6405b5cd9bso2458896276.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742674342; x=1743279142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XftD/bet0ahddNcDhTpxgjJPCDxkr3EcvVPGIXtlOks=;
        b=Bgm1m+1FdeLWjtREBOPjSk9vY5UBtgXcpNHpOuueqRpYA4vamxdeRh/+j+WnBrEOWq
         uoMUHIgLuSane7sljWj9063CGK/5/6MMvukCUMWbNYLxdNE/7yGrM9GqI1vQ4utblYhq
         8JQ2jNfs6LkMPylJ4guJBW5FL55Z6d2zZmiVdT0P34s/WL0NzTJSwL0FzYhF1euZkXkO
         YBeELP1ov+qDDivvRaTPXyxmKWiGDUamWdGqLQr7TlxhwBgs5AAjCbKcfraMUv0D6lQ4
         0MudcL+5Mjzi++nLVfgJQl5HEbtZ/jqQblnWngF4NjL16nnFY8pFVF12Nqd/Yl+Odqkv
         UutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742674342; x=1743279142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XftD/bet0ahddNcDhTpxgjJPCDxkr3EcvVPGIXtlOks=;
        b=jWdEc5Q8LeinhpR5lUOQ0HTbRe91xeLaxJCOCEvEvVhIMs7vCfk5CCl9TEjxYPq1Tj
         f+zfYFqEFrMbGeQbHfRN6BEu/i21TwEhtyw2ydmqOrhWIF/M2Hd+tLIy7jUYwB/Jv81G
         2YFUFvVYV1XBGO1af0l4ocqAODRmw5/v+FRtDhJRhiCJI1rtvNJnvK1t7kbH35DMWbxa
         KFBDpQN9EHbJl4lEvu08EynRMhHV6pzI8H+Qzw6Av8ytaaIiJPjnClCNBzTNcnHh/0Zg
         UjOe1i4hU3wFFlDYrUxxUrB9RXMK4l0jYbD9P+8GKk0Dvp1ybILV2Oa2FTOO0fkYygSG
         dD+w==
X-Forwarded-Encrypted: i=1; AJvYcCVLmlvWuC70FS9rpJV/d33qoo3vpi/ceRVEOcX+8gTtdeoj4iq7Ex8L63TMXRaPZWRfxmueph4rExxu5ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrQ0ZE0ok85BiTYwR3qLuuBtM3IUGRYuQ4UI5FZxYIiC2jCjz
	DoKupebQsoQAueCCaoQI/e55dMpzxZArNlLn8R/G6G2E1QzgBUHCNau+uILwcN8=
X-Gm-Gg: ASbGncue4zQSIhymuWrBRCY5TW8Am58830YrTFlHOq26bIyb02j1spfXOHHVIlImTYf
	hYAGra+KSNbN9NunAMIAh8XYjMmL+iPMZYfhbjnenqwzEWgCnq//Q1NcS8lzmSqIVWY7ddncaco
	o4wXjQI5uoQERGkVbd6wdn2KBPQsLrOWO0UR9agq2kSg+sWFdpU2ZryW/6tVqwqOQm2xI2vb8nf
	jXomIh7DzQ1fSguscrFAFodjFzBN7xwIkoQJa+ZAYz+jE0exK3z4GxWLUjbBc8YFY3GytJwU1nW
	2ZPk3S/kruYjHgScmlgKanFoc/M5kZOBNw9n3d0oy8NIcfzgRMrGZC0qiHANagraJSAJfnqdKt6
	bvd7ff54hCVqxDZyFr/QEeH0A5MfOCg==
X-Google-Smtp-Source: AGHT+IGHS6lOSvoLhDMVoyZEV4FQ3Hl2dcaBZHwKEjAP67NOWR+FvTBSQKC3rq/SW7tAZ1/KBxRqTw==
X-Received: by 2002:a05:6902:240f:b0:e60:88f9:b081 with SMTP id 3f1490d57ef6-e66a32ab0d4mr10539765276.17.1742674342100;
        Sat, 22 Mar 2025 13:12:22 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e66a4246db8sm880436276.13.2025.03.22.13.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 13:12:21 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	contact@antoniohickey.com,
	dakr@kernel.org,
	gary@garyguo.net,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tamird@gmail.com,
	tmgross@umich.edu
Subject: Re: [PATCH v5 01/17] rust: enable `raw_ref_op` feature 
Date: Sat, 22 Mar 2025 16:12:17 -0400
Message-ID: <20250322201219.1947215-1-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CANiq72=5Q=H1dUD+RQE+Bg579HvB8iE=hyFmtDAJD77JqoUjpg@mail.gmail.com>
References: <CANiq72=5Q=H1dUD+RQE+Bg579HvB8iE=hyFmtDAJD77JqoUjpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Mar 22, 2025 at 08:41:11PM +0100, Miguel Ojeda wrote:
> On Sat, Mar 22, 2025 at 8:12 PM Antonio Hickey
> <contact@antoniohickey.com> wrote:
> >
> > Ahh ok yea that makes sense, thanks Tamir, sorry Benno I misunderstood.
> >
> > So the reason I extended the dashed line was because before my change
> > the dashed line perfectly aligned with number of characters in the line
> > I changed. I figured it was supposed to match the amount of characters
> > of the line.
> >
> > Giving this a deeper look it looks like the all the other dashed lines
> > are maxed at 77 characters.
> 
> Yeah, it is just following other section "lines".
> 
> > I will update this.
> 
> Benno is right -- no need to send another version for that, I can
> remove the change on apply. :)

Yay my first patch to be applied :)

Hopefully many more to come, thanks a lot everyone I
have learned so much just through this simple patch
series. Appreciate all the help and patience +1

Thanks,
Antonio

> 
> Thanks!
> 
> Cheers,
> Miguel


