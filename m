Return-Path: <linux-kernel+bounces-177878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D908C45BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728981F214C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AE91CD26;
	Mon, 13 May 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fNT3p7jK"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB91CAAE
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620220; cv=none; b=idQo2458RbWNVSBMhfIceDfR1qnHG3LPCA12unLbxmyki2bk24iyfIcfdZb+3cNzlOXU57B2JN5P9Y4T9ZCEKL6FZSxAdnSiNjWvmFQIZVHfU6xRdPu+/EEcMnynKhwamlu1l2L6L06wZoeoGYPPjYw0qDQOnVae521ZWg041Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620220; c=relaxed/simple;
	bh=XSJBROMVrc2KsRXPebm2mlHLU3yXkxYWeY5FcmrQi0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B14ezCQ7VRC7ubutGujYZE+WWUgk2Jk2pB72MT2M0IjUKlskihvnbJHrmRRluZ7nMJlan/DRP1V2VUn3LW6N92ibFU212T3ycDeeM9ZyiPTEw+OusXZzVyO0x8tzOU1AjmIlhhPiZt09HPLLKBOUPMe+3CFdG5CT41QNrGYqwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fNT3p7jK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43dff9da88fso21721011cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715620217; x=1716225017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU8HU9DBiLf4SlmtDsASYOmsafllI/JgYmU6D8EfnDY=;
        b=fNT3p7jKZHxNdelF0s5AVli8ozZGYYt4ckQ0UeR8Bndgci0XetEhGG2+RkVVt8KLZb
         iTpxnsO5QrX+M3/OM7Bmia1NpWiv3xueMpBkHG3FrvSHy51SsiKooTMvOUeI/15bhX11
         twtE5nerxJH3UXik+hzpIVNsrG+Z8lDVByACwHxDuSI71MwwZKOxJ3Bc5n61cydUaId/
         KuKjGZBItNQbauSlFVAUh5iBH8YMbgALlKpm2QGzDr76rWeTBMC1PNbcCXYroI4dC+Gv
         BTgZjzEjgll5rZNmoqBB/TP0V5cGTJBzW7CqUQR+QPo9VW3SzZbhk8MQZlL3B6zLEr6u
         ilkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620217; x=1716225017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU8HU9DBiLf4SlmtDsASYOmsafllI/JgYmU6D8EfnDY=;
        b=glf7vkwTKcJdljnpaltIoC+HiXlC61hTOsw3UhaF9UyX++J+/c9f9aa6jHpEFb0WUN
         bFFPUSE//TJ9KbYotRIaz/f88cbpQ3wqnzsbLWNx5iWugVNUx5qWjHPwQON4H8tPBgUm
         0q3g80UyI1B9swhhZ25HlgE+ix+8MpTfYzYumeOaPRgsSeOEyyZDGaXvrTUokKnrJsSB
         8nVl71CzRCgJJuzOOEmK353Wo2NL31u7aEEIPaFz7k46TRXi9jrwBmBouhwghkaglwvi
         HU/J0GoMHWkET1WmLVPpkshQNRdG10XW2TQo0DB5w2jhvzLCCaaIcnDvN8Ex08wNihCL
         Hu9A==
X-Forwarded-Encrypted: i=1; AJvYcCU3iWPfStcw9n3ul272yWCoSMBItdEhEJcPIU5f85pHYOiDz7pY38pTrYV6wMncnsgDvFc84KkyMhZYMN0kpGa4yt89uVqqFFmr7jxk
X-Gm-Message-State: AOJu0Yz1K96M2owmNxyGNEwYhTfTsDUznAn8U6OrRtqdaw4l+cqTVTbu
	yB6ZclAgXuzQxwGgwThQIFNavveM2cFuhuEK8harhhGRWN33fdjECMe0JW0NBMYTPreMoSaFQ5s
	FopcO4xl+xHnOLk43xFWpVu50OEm7/3gH0O8Xa9CtQZmt/uc/YCc=
X-Google-Smtp-Source: AGHT+IHl2oHRFMJLef//4FI386W05SMQHXZdf4eeeBI3rSCCVptCoUj/vhx/CQlx2KdYKMNAhSEcpwhyhzFU3/w7nP0=
X-Received: by 2002:a17:90a:5318:b0:2a5:8ff:9d1 with SMTP id
 98e67ed59e1d1-2b6cc4547efmr9662680a91.14.1715620196414; Mon, 13 May 2024
 10:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org>
 <ZjY-UU8pROnwlTuH@farprobe> <D10Y0V64JXG8.1F6S3OZDACCGF@kernel.org> <D10YYQKT9P1S.25CE053K7MQKI@kernel.org>
In-Reply-To: <D10YYQKT9P1S.25CE053K7MQKI@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 13 May 2024 18:09:44 +0100
Message-ID: <CALrw=nFLa5=bPbYKijNsEo0Kk77_TEpdPmPe3CJ3VJqGNMmBeg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>, Ben Boeckel <me@benboeckel.net>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 5:35=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> On Sat May 4, 2024 at 5:51 PM EEST, Jarkko Sakkinen wrote:
> > On Sat May 4, 2024 at 4:55 PM EEST, Ben Boeckel wrote:
> > > On Sat, May 04, 2024 at 03:21:11 +0300, Jarkko Sakkinen wrote:
> > > > I have no idea for what the key created with this is even used, whi=
ch
> > > > makes this impossible to review.
> > >
> > > Additionally, there is nothing in Documentation/ for how userspace mi=
ght
> > > use or create them. This includes things like their description forma=
t
> > > and describing available options.
> >
> > The whole user story is plain out broken. Documenting a feature that ha=
s
> > no provable use case won't fix that part.
> >
> > So it is better to start with the cover letter. With the *existing*
> > knowledge of the *real* issue I don't think we need this tbh.
>
> As for code I'd suggest the "Describe your changes" part from
>
>   https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> and most essentially how to split them properly.
>
> My best bet could something along the lines that perhaps there is some
> issue to be sorted out but I don't honestly believe that this will ever
> be a solution for any possible problem that exist in this planet.

Sorry, I must admit I wrote the description hastingly and too
high-level (it was pre-travelling, so probably not the right focus and
in a rush). Let me restart from scratch and describe particular
use-cases we're concerned about:

Trusted and encrypted keys are a great way to manage cryptographic
keys inside the kernel, while never exposing plaintext cryptographic
material to userspace: keys can only be read to userspace as encrypted
blobs and with trusted keys - these blobs are created with the TPM, so
only the TPM can unwrap the blobs.

One of the simplest way to create a trusted key is for an application
to request the kernel to generate a new one [1], like below with the
help of keyctl utility from keyutils:
$ keyctl add trusted kmk "new 32 keyhandle=3D0x81000001" @u

However, after the application generates a trusted key, it is the
responsibility of the application to manage/store it. For example, if
the application wants to reuse the key after a reboot, it needs to
read the key into userspace as an encrypted blob and store it on
persistent storage. This is challenging and sometimes not possible for
stateless/immutable/ephemeral systems, so such systems are effectively
locked out from using hardware-protected cryptographic keys.

Another point: while the fact that the application can't read the
plaintext cryptographic material into userspace is a feature of
trusted keys, it can also be a disadvantage. Since keys in plaintext
exist only in kernel context, they are useful mostly for in-kernel
systems, like dm-crypt, IMA, ecryptfs. Applications cannot easily use
trusted keys for cryptographic purposes for their own workloads: for
example, generating encrypted or MACed configuration files or
encrypting in-transit data. While since commit 7984ceb134bf ("crypto:
af_alg - Support symmetric encryption via keyring keys") it is
possible to use a trusted key via Linux Crypto API userspace interface
[2], it might not always be practical/desirable:
  * due to limitations in the Linux Crypto API implementation it is
not possible to process more than ~64Kb of data using AEAD ciphers [3]
  * needed algorithm implementations might not be enabled in the
kernel configuration file
  * compliance constraints: the utilised cryptographic implementation
must be FIPS-validated
  * performance constraints: passing large blobs of data to the kernel
for encryption is slow even with Crypto API's "zero-copy" interface
[3]

TPM derived keys attempt to address the above use cases by allowing
applications to deterministically derive unique cryptographic keys for
their own purposes directly from the TPM seed in the owner hierarchy.
The idea is that when an application requests a new key, instead of
generating a random key and wrapping it with the TPM, the
implementation generates a key via KDF(hierarchy seed, application
specific info). Therefore, the resulting keys will always be
cryptographically bound to the application itself and the device they
were generated on.

The applications then may either use in-kernel facilities, like [2],
to do crypto operations inside the kernel, so the generated
cryptographic material is never exposed to userspace (similar to
trusted/encrypted keys). Or, if they are subject to
performance/compliance/other constraints mentioned above, they can
read the key material to userspace and use a userspace crypto library.
Even with the latter approach they still get the benefit of using a
key, security of which is rooted in the TPM.

TPM derived keys also address the key storage problem for
stateless/immutable/ephemeral systems: since the derivation process is
deterministic, the same application can always re-create their keys on
the same system and doesn't need to store or back up any wrapped key
blobs. One notable use case (ironically not for a stateless system)
can be setting up proper full-disk encryption (dm-crypt plain mode
without a LUKS header), for example, to provide deniable encryption or
better resiliency to damage of encrypted media [4].

Current implementation provides two options for KDF's input for
application specific info to ensure key uniqueness:

1. A key, which is unique to a filesystem path:
$ keyctl add derived test '32 path'

Above will derive a 32 byte key based on the TPM seed and the
filesystem path of the requesting application. That is /usr/bin/keyctl
and /opt/bin/keyctl would generate different keys.

2. A key, which is cryptographically bound to the code of the
requesting application:
$ keyctl add derived test '32 csum'

Above will derive a 32 byte key based on the TPM seed and the IMA
measurement of the requesting application. That is /usr/bin/keyctl and
/opt/bin/keyctl would generate the same key if and only if their code
exactly matches bit for bit. The implementation does not measure the
requesting binary itself, but rather relies on already available
measurement. This means for this mode to work IMA needs to be enabled
and configured for requesting applications. For example:
# echo 'audit func=3DBPRM_CHECK' > \
   /sys/kernel/security/integrity/ima/policy

Open questions:
  * should any other modes/derivation parameters be considered as part
of application specific info?
  * apparently in checksum mode, when calling keyring syscalls from
scripts, we mix in the measurement of the interpreter, not the script
itself. Is there any way to improve this?

I would like to mention that in Cloudflare we have found large
infrastructure key management based on derived keys from per-device
unique seeds quite convenient and almost infinitely scalable and I
believe TPM derived keys can be the next evolution bringing hardware
security to the table. I understand that folks here are not required
to follow links for additional information, but if someone is
interested in more details for our approach, which has been working
well for almost 9 years, see [5].

Hope it is better this time.

Ignat

[1]: https://www.kernel.org/doc/html/latest/security/keys/trusted-encrypted=
html#examples-of-trusted-and-encrypted-key-usage
[2]: https://www.kernel.org/doc/html/latest/crypto/userspace-if.html
[3]: https://blog.cloudflare.com/the-linux-crypto-api-for-user-applications
[4]: https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#=
Plain_dm-crypt
[5]: https://youtu.be/2RPcIbP2xsM?si=3DnKbyY0gss50i04CG

> BR, Jarkko

