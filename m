Return-Path: <linux-kernel+bounces-255090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33621933BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E712814C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C417F39C;
	Wed, 17 Jul 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="vutvKP5m"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C743FB83
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214244; cv=none; b=GKWJJe0VWyug2ZFtHc4iLfmrvDcOzyw2pYf0bjFLMivy+fwwlewUYOHA1rhsKdd6wUODLWsk/7YHO+9b0wx98WFDmjdXEXXd8DnGRnkteCaSnQy1i60Nt3+IKA+tWtNAG+RSxs9/y9eupoWwen/U8oYxF8RKdWW1AlBjc/XO5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214244; c=relaxed/simple;
	bh=BISw6QaYo5XGw4g9kcYQi/vCvP2PYYCiF3MeCq2fVFI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qKTLU7WiDiKuLRQ56s7+bxLIFHWKdX4z0FBZBy2IxZYWI8FHbcI63KjG5i6mcn7U7lghS2DJJQrylAiw2GVLvSIxSdy/bYt4AZsiiNK7m8IqyFV6f8ZBIKtm8hg+r1N2G2pQ5kzgpzn5ofPqFClPfvuNFLjQNgjHjDIXHYLgIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=vutvKP5m; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so43375465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1721214239; x=1721819039; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BISw6QaYo5XGw4g9kcYQi/vCvP2PYYCiF3MeCq2fVFI=;
        b=vutvKP5mO5yJZfgL6NY0i5pe/9u1TdeOWI4SnjXNCpFyX3FGaZnZ6wtRslmBeXODYu
         2CIY+fs2XJMbPPlIe9nAimchkDJIz5uf8DNirxMtxVGzB9+YaHjXWEwxG8VHrXH3m97u
         kkAD0/SCz0afSe8iaYVdfd+UDFx0938xefudscIsQTfb6hFiXkHGiUN6YPCtoanqICbp
         FytCooA4kVIy10XrywJ8kdMoyTp20tlUWXXZlqpWGjWscwyzCFu2UtZzp2hixFrCRc8l
         Sb+SfZqsDEN3LeQs0GEjo/MDL6GBus6Om+JWAAtuaO33Io3ZexA4w4NLDolcnNE3gZtG
         StRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214239; x=1721819039;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BISw6QaYo5XGw4g9kcYQi/vCvP2PYYCiF3MeCq2fVFI=;
        b=ZYehlF2tw+s9XLZcx4CWgkei7bdxLohcdUIFlHa+b2ZfGSy3W+0d8EqhP4vTd6Nx6f
         RNWU2QarQsiHd9RSanAFqbKTcD+JdeNVCCj8u3zR75Rd+4mIWtGt9NjHCoOuCgVoS23K
         OOKk/x30ycwVqJ2NaIAA5q3qCkbDd8dV3V4HO8ZZtXd2ZOmwpagZSWrrjzg18fu/3kP4
         y73DlpqdLWjdQj5fD7LBMwPICSRdTTCU0kbdOduLWg0KXpVk+XRKYrpXl2Nh2xDf8QdV
         ra/bw0xbsq0v8srUAPRvaqE7CXrCKf8vkdAJbIAEujEXNbG1niDKWuLqErSy2MwXnxkc
         3hMw==
X-Forwarded-Encrypted: i=1; AJvYcCVgeWZQIHdxoXLBfEtN8P2yax9GTZKcVhrOD1q1UjC7rrxWy7z3Wrki9wPLtjtv1+WH0DyBQYM6pthxDQZgj1tvyi8sAGBJtsjnkyPD
X-Gm-Message-State: AOJu0YzQrcHFR6zrFlRi39vmzBI5b0XtrHb7ypReYttQpPlaeaObGYF5
	TleDYeqnTkEJKqtPLe4DeH2Dpawxn7SCHh3Q5umPZC+owmFdANJzOSVnQC50MREjgQGCzdUIsE9
	z
X-Google-Smtp-Source: AGHT+IEDplGH0IVfvijmWw8u0JGSe1acucXgpm0GKMtZZyBCxjNkFTfli8WiN3/+52j395E7jXaZoA==
X-Received: by 2002:a05:600c:4510:b0:426:6f31:5f5c with SMTP id 5b1f17b1804b1-427c2cbcbffmr9472755e9.17.1721214238878;
        Wed, 17 Jul 2024 04:03:58 -0700 (PDT)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb525sm164901895e9.34.2024.07.17.04.03.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:03:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 1/2] KEYS: trusted: fix DCP blob payload length assignment
From: David Gstir <david@sigma-star.at>
In-Reply-To: <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
Date: Wed, 17 Jul 2024 13:03:47 +0200
Cc: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 Richard Weinberger <richard@nod.at>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE5319C4-F81F-4C70-AF74-B0B32DC60CCE@sigma-star.at>
References: <20240703125353.46115-1-david@sigma-star.at>
 <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

Jarkko,

> On 17.07.2024, at 12:07, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed Jul 3, 2024 at 3:53 PM EEST, David Gstir wrote:
>> The DCP trusted key type uses the wrong helper function to store
>> the blob's payload length which can lead to the wrong byte order
>> being used in case this would ever run on big endian architectures.
>>=20
>> Fix by using correct helper function.
>>=20
>> Signed-off-by: David Gstir <david@sigma-star.at>
>> Suggested-by: Richard Weinberger <richard@nod.at>
>=20
> You cannot suggest a change that you author yourself.
>=20
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: =
https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@intel.com/=

>> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted =
keys")
>=20
> Tags are in wrong order. For next round:

here=E2=80=99s me relying on checkpatch.pl to tell me this, but it did =
not. :-/
Anyways, thanks for reviewing! I=E2=80=99ll fix the tags and send v2.

BR, David


