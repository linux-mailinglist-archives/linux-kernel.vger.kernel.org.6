Return-Path: <linux-kernel+bounces-286327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB79519B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF261C2299D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1361AED49;
	Wed, 14 Aug 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyzzIrM1"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F11AE851;
	Wed, 14 Aug 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633949; cv=none; b=P1/17OVwdXB3jrsKwZn+3be8bsJsb3JWKrIzTiuwpavbKtgg2mvt9vkxvllIiho4MR9z8vmD2A3Y789AtSwngqrAEXqzyXqbv8csvyAQmrWvWF55nJo16V8mrtf1r3sNK6gVvyHdEIty62KcsYONFjhU3XaDP6Co9ZrSfFI1Njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633949; c=relaxed/simple;
	bh=/jlXwub/VVgwOLNXo3NHY827Q79tOts0INn1SM8RMmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cA56IveAEuvs5y8gciumnU6u+rIrPwLAisobUCbPTcmK25GHfzfxAZIVxS+4v74COfcMXn2ouwh7wBWI/M8smYy/KaCSGZXsX0RdMrvN6kPqc6KiLdjf+J2vQocgDjBB9u3XBZHr6ABE4D2oDeRttaQCNzPWK9icZgb4gMo7Q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyzzIrM1; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39b3e127748so27861945ab.0;
        Wed, 14 Aug 2024 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723633947; x=1724238747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wF+jCqkozllmCMkDBC4WnutIDupaU5S+6zMucrtIowA=;
        b=YyzzIrM1Rv9Ksru9dCLHgm1h9sd0+ah5S3L7tAFLAT9y5A4IY3fPurxvY8LtJ4Dk7n
         /pWFw6Q3o5Ht3p5WJ97kT1HH78vFW2A954COM6QUAPlILC58xLdmNTUHksDKrxtLN1Ve
         Vb+aswUNo9yp4wSLyTNICmu/GuHgvdtDNGNQJJJbXMH+rfa/nlunrG2ZeA6mo6t56ggm
         tRBsLJjGtQFzK1PX3oGHSwf3GOh+4JlB39pnOXNdc56zv/GTn46IuRNQ2wHq1D1F5Ko5
         ILmZT6v/K3tHqy6I7v7Rr9clzORel4iyWPn+q8+w22ntwqGoZrEn9ahf+VHG6OhZub9u
         gflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723633947; x=1724238747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wF+jCqkozllmCMkDBC4WnutIDupaU5S+6zMucrtIowA=;
        b=SbbjFdQXa3H8bGcci56glnSPAqKR8Ep+EQ319ORTHYLTs+xwmAjNqZaBWkE74zA3cO
         WBOzmmwNj0C9J7yNKX44VU+g130ihvdt0lfZ2pHLWZn6upnwSvnYH3ZJQENXLCa2/O9f
         pkXsb/e596EqA6192uzIeAVmruR5QY7GWWNuq3Z4FQEXFVKHq3Mcla2m29xXd2cSkIPX
         bgLAiOWaxnanECPX+i9dDRdfizlIhlfwRtRIcuYyS3fRuWL8iTvT3htb4ZVdh0Qdmx0A
         UIKuniflL58R5bRPTeB04WJsLYFHx9e1Ozz3xmf0C4mq+/xvL3U+T1sWbTzAUNz2R8o7
         91sg==
X-Forwarded-Encrypted: i=1; AJvYcCVT7eSRJ/Wb02qvYbXfW7x+OA3ytMq4Xc/xFMcOFFFaTKbZFNnYgc+D0Nb17AO3SoGurBbgCUt+zfRdrOokmtu62PF9Yt4dfrG3J6GqK/gvg78NoXim3H7AdZwu77+kya0qRDYXMka72e0=
X-Gm-Message-State: AOJu0Yy3ojdkzygQguQuPFtvZMa5dIT2EcAuq3XJI9Yejeu3xtVA0tMl
	XX9NOYqzmLmmnwr4fYmp0gWMnOCqTD6LlJnIeB6TtzxiTg+bsiGrebR1hdcl2TEgTlf1sSGQfl1
	wHP8ebBTngjYSFq+gziWCuO0Tnww=
X-Google-Smtp-Source: AGHT+IG23mxNg9sYomPIR65C+wkvcVf1Nh6cR3dMcXd5IewSmI8C/wXzw+Jopbl3+u3Bq8STYJPegmialAMApjmL47Q=
X-Received: by 2002:a05:6e02:20cf:b0:39b:3205:6b93 with SMTP id
 e9e14a558f8ab-39d12520b17mr29843795ab.28.1723633947217; Wed, 14 Aug 2024
 04:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com> <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
 <CAA+D8AN9JXJr-BZf8aY7d4rB6M60pXS_DG=qv=P6=2r1A18ATA@mail.gmail.com>
 <ffa85004-8d86-4168-b278-afd24d79f9d8@linux.intel.com> <116041ee-7139-4b77-89be-3a68f699c01b@perex.cz>
 <930bb152-860a-4ec5-9ef0-1c96f554f365@linux.intel.com> <c9039808-cd04-452d-9f6c-f91811088456@perex.cz>
 <ed1192e0-00e7-4739-a687-c96dc2d62898@linux.intel.com> <CAA+D8AMOh=G7W5-dYw_=Xx-s0PqEu2suKYorscoWku86Rn-=+A@mail.gmail.com>
 <542d47c5-7ce3-4c17-8c0a-3a2b2a9e6c6a@linux.intel.com> <c3b8f7b8-fc5e-4285-bee8-7edd448a405d@perex.cz>
 <CAA+D8ANg7C7vuxU44mAG8EnmcZjB_te5N_=4M4v_-Q9ZyPZ49g@mail.gmail.com>
 <2be4303e-58e1-4ad7-92cf-f06fa6fa0f08@perex.cz> <7dc039db-ecce-4650-8eb7-96d0cfde09a2@linux.intel.com>
 <CAA+D8AMv=tHV3b-Rfo9Pjqs0bX5SVschD=WD06qxjJOk5zQmiQ@mail.gmail.com> <3cdb2041-59d4-4d43-ac4d-39d7f9640cef@linux.intel.com>
In-Reply-To: <3cdb2041-59d4-4d43-ac4d-39d7f9640cef@linux.intel.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 14 Aug 2024 19:12:16 +0800
Message-ID: <CAA+D8APSrH_pum6Cm0YxDzWMs4Roi=h1hkBjPMfXocXt7z4oVA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, 
	tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 5:40=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> > Yes, to go further, I think we can use SND_AUDIOCODEC_PCM, then
> > the SRC type will be dropped.
>
> sounds good.
>
> > But my understanding of the control means the .set_metadata() API, righ=
t?
> > As I said, the output rate, output format, and ratio modifier are appli=
ed to
> > the instances of ASRC,  which is the snd_compr_stream in driver.
> > so only the .set_metadata() API can be used for these purposes.
>
> Humm, this is more controversial.
>
> The term 'metadata' really referred to known information present in
> headers or additional ID3 tags and not in the compressed file itself.
> The .set_metadata was assumed to be called ONCE before decoding.
>
> But here you have a need to update the ratio modifier on a regular basis
> to compensate for the drift. This isn't what this specific callback was
> designed for. We could change and allow this callback to be used
> multiple times, but then this could create problems for existing
> implementations which cannot deal with modified metadata on the fly.

.set_metadata can be called multi times now, no need to change currently.

>
> And then there's the problem of defining a 'key' for the metadata. the
> definition of the key is a u32, so there's plenty of space for different
> implementations, but a collision is possible. We'd need an agreement on
> how to allocate keys to different solutions without changing the header
> file for every implementation.

Can we define a private space for each case?   For example the key larger
than 0x80000000 is private, each driver can define it by themself?

>
> It sounds like we'd need a 'runtime params' callback - unless there's a
> better trick to tie the control and compress layers?
>

