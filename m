Return-Path: <linux-kernel+bounces-349170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C398F20D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8B41F2266D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135D1A00CB;
	Thu,  3 Oct 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="PPnUN4Qe"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297531A01BD
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967743; cv=none; b=EsWE9oSL2fC6bGySh2PmtYHyqnGhsL0UwUwKm5bCOlCPhKjMWRQn7J3XpAEJm9eBY9AomfuBD1xDPR0/tC93qiLwnqkhOJuV6zrLT8BWEy/Sj4mtPuwZl2pACL/mrrPQKhYZf60gIVMiN0c+qlDJhTf1BIEq5f4w1QCwtR1Ph2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967743; c=relaxed/simple;
	bh=0o4zGq1l8dC78VSp0hLET3Oej+NTqvrr3gSjrM5DOQA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sLXPK6kVCES2FsRaZNNuLukD8sUI2K4+DIx/WEPHxiTSQlO7ia4fZxusfquxSDNhtWK/L4NjFXAQlOjKZK0Com5IkwtoOE1Va8q2/OiBnFDuHRrYEd8crhSYIolZzleBDMJVo+TWPmKLygXBs+aXgLvdLAU/NT46lIXX68PVJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=PPnUN4Qe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42f7e1fcb8dso1560735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1727967740; x=1728572540; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o4zGq1l8dC78VSp0hLET3Oej+NTqvrr3gSjrM5DOQA=;
        b=PPnUN4Qez86O089vD7a8sJNhsX9tMJH7zcGs+TYQBoItiEL+5wwcnzr2fvEjGEMNBE
         uX4pev5xIaR0JeBLwTP5efirmXrcBRTWh5tCRGx8ija5Xd0ATN4wzH4k821y62RYPWFI
         S6h9Q1r+6LTjLKIjABIidSs+71sO6elHTRqvOG7GV3tBf3SQBUbktaabnetybQxbrV/Y
         m6AMrPv7Q/W1JS4hysnmxETfjg9I6p5+DebN/c/P4ELnuEzgw5Au6al7iBw3/upvOLQg
         pULPc+LxpujHEeHc866jZFOKdseyJjxsECI/7GIhjmEvAzMbxJjDdXOhMx335MiH3Miq
         33uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967740; x=1728572540;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o4zGq1l8dC78VSp0hLET3Oej+NTqvrr3gSjrM5DOQA=;
        b=Q3h3F8MshPgEBhWWSmMCvjmVbHNlo6NORkQGU97zhHLt63SV0/0tnSUjRbq78dRTlC
         3CTryn62yDxnmYJSb5dU3gJVR8xuWdR8Ah23A3VXXb6NzGfuEaje0AjoMXxfnsSNxZ/L
         O5qCXEjKqg5ms/8YTYWzApYOcgnkvrnld3DWbx+EehuTyQC1hz9sz6xFNxC1TF1joZ1j
         I+tXa7Bhnm2stBA/r5dyaLFlBKXFScjvENCNa3lUSJQHjkjkkIujMDku3k4vttGF1VzV
         Ehf7hZQNkYTC+KsMFu3i4oW55Brb3QPhVcMbzkwaKewmnolZ4sag/uAHatHCJGGJwZrS
         OdpA==
X-Forwarded-Encrypted: i=1; AJvYcCUhi0JPuJE1y9Soo4JzJHhvVHFu0bPS7Ktt7A4AbxUZySG40ewhDjaGmfZgjmFM0GUNAZ6Af9+QYKqktM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TFMB8MoW2hgtFRtqrnRYyFWT8775xYFNnk8gp8KFfjChmWmC
	8pTALm2d7faumHsFNHO6S9ezJXldDD4LVM1oZ6jCJF91r5UueQOqo7Hx0DDnWHs=
X-Google-Smtp-Source: AGHT+IFkImjjIUquq+gA7uxKoSKuU17rdWrRxPkQdJ+pAAJ+j4djTiCNVLXTTtRJsnFkETuOUvqxoA==
X-Received: by 2002:a05:600c:358f:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42f777af26amr26043395e9.2.1727967740138;
        Thu, 03 Oct 2024 08:02:20 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:1558:85f1:4dd0:3ea9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm46665475e9.17.2024.10.03.08.02.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:02:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in
 bch2_xattr_validate
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <Zv6YInHiwjLeBC3D@archlinux>
Date: Thu, 3 Oct 2024 17:02:07 +0200
Cc: Kees Cook <kees@kernel.org>,
 kent.overstreet@linux.dev,
 regressions@lists.linux.dev,
 linux-bcachefs@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ardb@kernel.org,
 morbo@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <63D4756D-31B7-4EA9-A92F-181A680206EF@toblux.com>
References: <ZvV6X5FPBBW7CO1f@archlinux>
 <3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com>
 <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com>
 <Zvg-mDsvvOueGpzs@archlinux> <202409281331.1F04259@keescook>
 <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com>
 <Zv6BEO-1Y0oJ3krr@archlinux>
 <E8E64A72-3C1C-40D2-9F07-415F6B8F476E@toblux.com>
 <Zv6YInHiwjLeBC3D@archlinux>
To: Jan Hendrik Farr <kernel@jfarr.cc>
X-Mailer: Apple Mail (2.3776.700.51)

On 3. Oct 2024, at 15:12, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
> On 03 15:07:52, Thorsten Blum wrote:
>> On 3. Oct 2024, at 13:33, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>>>> [...]
>>>=20
>>> This issue is now fixed on the llvm main branch:
>>> =
https://github.com/llvm/llvm-project/commit/882457a2eedbe6d53161b2f78fcf76=
9fc9a93e8a
>>=20
>> Thanks!
>>=20
>> Do you know if it also fixes the different sizes here:
>> https://godbolt.org/z/vvK9PE1Yq
>=20
> Unfortunately this still prints 36.

I just realized that the counted_by attribute itself causes the 4 bytes
difference. When you remove the attribute, the sizes are equal again.

>> I ran out of disk space when compiling llvm :0
>>=20
>>> So presumably this will go into 19.1.2, not sure what this means for
>>> distros that ship clang 18. Will they have to be notified to =
backport
>>> this?
>>>=20
>>> Best Regards
>>> Jan

