Return-Path: <linux-kernel+bounces-576133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06180A70B76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A174E3BA5DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66F265CDD;
	Tue, 25 Mar 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="p7+gXmGZ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDF1E1E05
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934204; cv=none; b=ZMWyWR09EbIuT6Z2wzYqi9vNTWSB9RWVXSuQ1SmtX8xuLx2rY5Sx9We2s6og2r5qBsBxqO41nzBdllVw6QFmkQhXtt26jgemH8vl/13ymtHdyVyyvSiiaza5WoPEQAbLKQOgZyfI9g3CqKsyGAt+IEtwCbUg1DfZTJqdnhXPvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934204; c=relaxed/simple;
	bh=ogqybZep0WpZHhJtz+jCutY9Y5w0gsZQNbwghBWP/kU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ahA8CQp5nIdoXhPyGrDgi+wKapwFg25gyU4H7YdrNliFWFqucfL4QkJcfvqr3Lokt/bsyJhhj+4gTc7+Ai/3Ld6LOpzkv0XrHLCuRZHiBF6/D+Dj1emEEEgLJPVZImLc90p5xPMmjlPpMAYq6+X1aXdyULvI8JRh72SiUMvujLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=p7+gXmGZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso65802671fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742934201; x=1743539001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7pKjJ2eC+e0PybVh41up22kgdJeIh8izK8jO6PVSqDI=;
        b=p7+gXmGZmPDkCrZxrOAm9Oea6X9IZtg7uQnj9mo+9wFgllTAucYp71MAQXS2JqGfii
         +YnahwOvX3gmgRwecY+et8wk3fLpYBA1Tzs2pNkxdqdmX4eXHnE6OUk4YymKCA1dc7E3
         xel03q5hW1wLJiqq9uJPAqx0/TFVZWWsXc4noJicS5ID82Wb+dNNTQQE9oSLq7cSdhaG
         lcNaEosl6YbF23GY33u9eaNvp4WEcEXm/HBn9+jxOb7PupBQ1EFIufKk6LIU1q1KFR6d
         I3PNYfbjyifsVnPABh4y1Ow16ILkHOj85r2EQVcmeKBkQSovPRSJ27r5N4BBE7P2epCG
         5aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742934201; x=1743539001;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pKjJ2eC+e0PybVh41up22kgdJeIh8izK8jO6PVSqDI=;
        b=wwgEaywwV8ajvW1hojicfjNgBsoJ7h6btDAZBnqcjF5COQFt2tD7Dlsrr8Aqi+VpTm
         UrRfLOXEeflZX9uGEEQdMrYR65yQxR61uysyoBVW4HFYELTqdjFuiY1S2cwQfpbH9MnU
         LcTBr8NdXWMGU0c5Ab1Z5Yboj3VHHbnhDqvjZaKG7RNoKwPKuNk02dh1n0WbooqMh6L0
         DkKtRcOjSdtJFcLcw2Bys2DcCtLHDUCrbaFwdakdAoLVu89X67RG8xivavxTOYf40qc2
         addeC/OFuPM08VlWJY9zYAYRdpTxW5DMWR30FlbFNPFebjPZnTQxrKHgZBdsajF54Hsj
         LyWA==
X-Forwarded-Encrypted: i=1; AJvYcCXGxhXvdtlpKnXt6o//122mDcVp/CN4S0qpHlpLlS5vsHKTosHXYTxphi0sKAAmgnJIJwxHLr4SFDUzv/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0b8B64RbpT/XaYhKIQHCyKrTAG5c6F8ZMN8M0svKqyKEi8IaA
	DXJVGBOqncD15fe5DVpboEOtHJsGu/vkhDrvrQ9liVGx+fXMycmPrMmyQLX0WLfyusleu197EAy
	rTjAic0VoFa5iNINENo4fvgEDh3WiJvzWKhZExA==
X-Gm-Gg: ASbGncvxVtHjNka1T71H93/sks5gESzUeibGWYqsVpgh80EXU7g5VVj1oJdMpe/X1rA
	s1Adhmu+B85oq25MFg9i9EV2ZLgSNrne9whNKx/ZtQnI2MAH4gGYmxKGpi/Nt0vFBXwsW8MKKhG
	h59mNh1ejOG4h+Br5XOM10hHAU0ODAMkP99uYD0K5OFYp7g3Pk71aq+gE+VxsJtV0Bjwk5
X-Google-Smtp-Source: AGHT+IFwRv0VjE0s/GJ46BOQexbEb5Upg0Hji7i69VOssvtOIg/ehyb1QubPQ5OLohIIIsjfjU6LmWiGVEPvqAVtO4I=
X-Received: by 2002:a05:6512:2351:b0:545:a2f:22b4 with SMTP id
 2adb3069b0e04-54ad64b30ebmr4535451e87.40.1742934200566; Tue, 25 Mar 2025
 13:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Mar 2025 21:23:09 +0100
X-Gm-Features: AQ5f1JpPH6ZDUnCojhOyjkakFsEShyIEY6JLnlsg7I56gqe3bOOQxr_zQzcp5wI
Message-ID: <CAMRc=MdO=vPrvvonJPJ=1Lp0vFTRBtsEBUS5aqWp4yMqUtgfzw@mail.gmail.com>
Subject: Extending the kernel crypto uAPI to support decryption into secure buffers
To: Herbert Xu <herbert@gondor.apana.org.au>, Kees Cook <kees@kernel.org>, 
	Jens Wiklander <jens.wiklander@linaro.org>, Joakim Bech <joakim.bech@linaro.org>
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
	Gaurav Kashyap <gaurkash@qti.qualcomm.com>, Udit Tiwari <utiwari@qti.qualcomm.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi Herbert et al!

There are many out-of-tree implementations of DRM stacks (Widevine or
otherwise) by several vendors out there but so far there's none using
mainline kernel exclusively.

Now that Jens' work[1] on restricted DMA buffers is pretty far along
as is the QTEE implementation from Amirreza, most pieces seem to be
close to falling into place and I'd like to tackl
e the task of implementing Widevine for Qualcomm platforms on linux.

I know that talk is cheap but before I show any actual code, I'd like
to first discuss the potential extensions to the kernel crypto uAPI
that this work would require.

First: why would we need any changes to the crypto uAPI at all? After
all other existing implementations typically go around it and talk
directly to the TrustZone. That's right but IMO t
here's some benefit of factoring out the common low-level elements
behind a well-known abstraction layer. Especially since TA
implementations may differ. Also: in the case of the Qualcom
m trusted OS, the single-threaded implementation makes it preferable
to offload only a limited set of operations to the TA to not keep it
overly busy so a dedicated kernel driver can han
dle most of the crypto engine's functionality on the linux side.

And in general being able to decrypt into secure buffers may benefit
other use-cases too.

There are at least two points that need addressing in the crypto uAPI.

1. Support for secure keys.

This can be approached in two ways:

- We may expect users to already have generated the secure keys from
user-space directly over the TEE interface, retrieve some kind of a
handle (secure key index, wrapped key, TBD) and p
ass it down to the crypto framework via setsockopt().

We'd probably need to add a new optname: ALG_SET_SECURE_KEY or
ALG_SELECT_SECURE_KEY or even ALG_SELECT_KEY in order to differentiate
from the raw keys passed alongside ALG_SET_KEY.

The underlying crypto driver would then have to be able to select the
key from the TZ. In this scenario the crypto core assumes the keys are
already programmed in the secure enclave and
it's just a matter of selecting the right one.

- We may also prefer to do everything via the crypto uAPI, including
generating secure keys. This has the benefit of adding a nice
abstraction layer for various trusted OS implementation
s which differ from one vendor to another.

To that end we'd need to introduce a new af_alg_type instance that
would allow us to manage secure keys via setsockopt() or
read()/write() in addition to the above.

An example user-space side would look like this:

struct sockaddr_alg sa = {
   .salg_family = AF_ALG,
   .salg_type = "securekey",
   .salg_name = "qtee", /* Qualcomm TEE implementation */
};

sock = socket(...);
bind(...);
fd = accept(sock, ...);
header->cmsg_level = SOL_ALG;
header->cmsg_type = ALG_GENERATE_KEY;
sendmsg()

2. Decrypting data into secure buffers.

Here we'd need two things:

- passing file descriptors associated with secure buffers to the crypto API

Other than using setsockopt() to select the secure key, selecting a
symmetric cypher wouldn't differ from raw implementations but the
message we're sending over sendmsg() would need to c
ontain another entry that would contain the file descriptor associated
with the secure buffer. To that end I imagine adding a new socket
option code: ALG_SET_MEM_FD.

- one-way decryption into the secure buffer

This would mean that the write() of encrypted data into the socket
would not be paired with a corresponding read() of the decrypted data
back into user-space. Instead, we'd need a mechan
ism of getting notified that the decryption completed (successfully or
with an error). That could be achieved by polling the socket for
POLLIN | POLLERR. A read() on such a descriptor wo
uld return -EOPNOTSUPP.

Please let me know your thoughts on this and whether any of the above
even makes sense. If it's not a terrible approach, I will start
working on a functional PoC. Please note, that I'm n
ot very well versed in linux crypto so I may very well be talking
nonsense. In that case any advice is welcome.

Thanks,
Bartosz

[1] https://lore.kernel.org/all/20250305130634.1850178-1-jens.wiklander@linaro.org/
[2] https://lore.kernel.org/lkml/20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com/

