Return-Path: <linux-kernel+bounces-545288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C3A4EB3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99736179FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B616294ECC;
	Tue,  4 Mar 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JW7t4fEB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A1294EC9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111342; cv=none; b=m4ldp+8qcQk0XzAdTdG9meT6D04I8uKVISNAmJk1VgoNEia87I3tHARCI5jcSxgO2PVpqKsQvxW3k++QhC/7kLMyM7tnpepOYhIdOuj0tBQ0yzS3uN0pFtnl2UbWuC3kHJlqzuPwg6JPezEkx5scZdA8rbtsHrp6Q6AAGl190xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111342; c=relaxed/simple;
	bh=dwlCICgBvjVCGr7BVidpNH2woY9QKhCraMbFnYt8Dzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RC45ghgnxvqkMNjYEyAKXXuPNGBwx6P29SuKRsiBuW3dfVn2lUaEtoPET+YFN/M1PKrN7eFL8eA/qnJhh1ffD+LCQVPBk+yJzjkGjmyWGHLQ9AkK82wxpWPfxqcvampFXbdZ7ktMgU5aTxrOZEOw5AvcCjTdIio3etMOz7QG5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JW7t4fEB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54954fa61c9so5175479e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741111338; x=1741716138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q36U1qa7lz9QnvyXi8cj7aYNXjnZ30zhkSSKwxKgUII=;
        b=JW7t4fEBvCSEdlHIAVx/BUBmBkadIJt9p7WBkxyu3mtSnm4IpfOwOBq0GnT0RD19uZ
         ECs2BBccgVsEfWWOnZScogd2ASPja/0C/8UNWvt5bS/uh7X/YJ442zKRssHrSvbvkkUb
         mX8XWzXdDXkNM3mp93eqavtApiGt8VY/SWbgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111338; x=1741716138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q36U1qa7lz9QnvyXi8cj7aYNXjnZ30zhkSSKwxKgUII=;
        b=sjQeBXWYGk890RVM0MSPgtEbL3Hy2QelxXCJHPCk8JojirE1L+hgQmx+YZWXPAwPVE
         rKKcr/zgRPHbvfvG3Pi91sVEvXBofLPrhEp1tk0PReExiOQsJi5avOcht0NZs1+PX9Dh
         OUAywtOQWtvZLdaAcNhnhQwt7Htmr6CzvEdtkTHWXaPE+YY+01WO8ORmAjGoNRZBdZUJ
         sxo9u2TfRCUiOk3on1XB39DEL0EBbiiytyAbzx2Skc3bfwuw0rWxsplsiGMzJM6OJTME
         8eeqXT5ebHxLQvlLwdFQLnb0sqdrtoPnj1aQPiHbyMDceZC+0ppgIteTp18tSIEb4zJg
         XkSQ==
X-Gm-Message-State: AOJu0Ywta+mAXXB05gfPAguldmssKbPTjC5yo7sJPdc21QKWHZTyM49J
	fqR0kzs+MGVzfcR8EFDuZbfqqBh5BcfLK5PF6OyQHSJkol8WzkMO2UsrXq3PVeV7ge59yzSMTxb
	SdDM=
X-Gm-Gg: ASbGncuGdtjaD9fs07occt+5C2dwbGKlyfTiyw1JJXqgjEXbk3MLqat3XrS5Bq3IRTa
	r2AHjvIoMlheY8H+/k49eTW8jGWxwit1N5oUa2oRYKZtkS4zrhO6QlwMvnNwjBCYygqXsB8hU7w
	bgYhXSITTP0hg2RgVwWIEEhP4CkNdG1tQKF5k4YrHuPgTnhA0ZlpCxg9Ns8/yzaFyclwwsFb98x
	pfJUqSdOjlGGl/9EmP3kP9yokrfH2SYbYOAvXc/oCyanxRUkawcowBC3w5HvRyKWWyt56QTYiP1
	obgZ1ZPnCinsiA/ik8nNjEmS/SaG65EkCpQL/LUa/FHkWOPLNi2pSAJB2kqsRocmXVEfyPInC+8
	e/kiB+mveG3VU91jDvTfM5rQ=
X-Google-Smtp-Source: AGHT+IE/A/JAM/QLorB+i0RKfQDCMMIZ+vOFSkiUdeWY3x61SVMEkM4rfBLELpqt8IYMHmZl8GB9Lg==
X-Received: by 2002:a05:6512:1248:b0:549:4bf7:6463 with SMTP id 2adb3069b0e04-5497d389d13mr29190e87.44.1741111338154;
        Tue, 04 Mar 2025 10:02:18 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54958e795b0sm1128353e87.22.2025.03.04.10.02.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:02:15 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fa8so64380911fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:02:14 -0800 (PST)
X-Received: by 2002:a05:6512:b05:b0:549:78bd:6b8d with SMTP id
 2adb3069b0e04-5497d37a981mr30735e87.39.1741111334440; Tue, 04 Mar 2025
 10:02:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
In-Reply-To: <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:01:58 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
X-Gm-Features: AQ5f1Jpg7NumWYmjX4cZrIeXlN6G1CJCazg40Tn5gbT0_0X-Apg_WOnDgtXua6I
Message-ID: <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 07:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Put another way: the old code has years of testing and is
> significantly simpler. The new code is new and untested and more
> complicated and has already caused known new problems, never mind any
> unknown ones.
>
> It really doesn't sound like a good trade-off to me.

Side note: it's not clear that we should need to do that
ASM_CALL_CONSTRAINT thing _at_all_ any more.

Iirc, the only reason we did it was for old versions of gcc, and we're
already in the process of switching minimum gcc versions up to past
where the whole thing is relevant at all. There's another tip bot
commit that makes the minimum gcc version be 8.1 due to the (much
MUCH) cleaner percpu section series.

And afaik, that makes all of this completely pointless.

So tell me again - why are we making the kernel code worse?

                Linus

