Return-Path: <linux-kernel+bounces-286701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC04951DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A451F22FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6E1B3F18;
	Wed, 14 Aug 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvhgYLqr"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD281B1417;
	Wed, 14 Aug 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647817; cv=none; b=AuoD8+eoI7769YD8XFzxT7j/sZMVZZvP91tx/VQrQyDslHAlNSrxL8Zh+heffZmqQgM8MTAtnnO1YOHUCg6zda7kDoohSC1j60G4lntjYpMj4xsuvgBAp/9Tc4dMHpaj8GsNeAsT4gPgbk4PxF8+yaICsWUEwFkHjFZCeYb7lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647817; c=relaxed/simple;
	bh=YJ7nwNrJJ7BJlmzVGIzhqsZYBiUCrpKTHuGFi7YsVBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIu38wyA8iaoJ2vbBb/u/DeXlCgZahTSPw3eikpWua5EZ3A36S08rbEIV3OAALW8RO9tUfYUiwpTP00O+HGEMXDOkZ4UeWmeZWSS7vf/uLWt3aQZxfsauRH+gJd7f1Xn+63XAfR5AGatqMqLCOpeMT1C0UeMCyB2DsM19hbBnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvhgYLqr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so124394a91.1;
        Wed, 14 Aug 2024 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723647815; x=1724252615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ7nwNrJJ7BJlmzVGIzhqsZYBiUCrpKTHuGFi7YsVBU=;
        b=dvhgYLqrNSLH1Uc/v8WERHIYZ3ZHsCSSzUOQys9R+M0srwq9AUnnm6diDwWdzfMA8W
         Bu77UPm+pE6RMfDxMPPV71qnvxdm8DOudjMXiOEhTFDENXAN4pKIAC0gga96dUFteoMZ
         K7AlN/21tt0/Z8sQQM04+xLgQakXy5kCGuyXmU9wEjn9wCkYOAcogCjAZ4mwhbcUiXSH
         QADyzH3hQlnTbZ81zpXcftCYf7nU+1KDw57hJT+q8tVBr/ibMnZJVPbMkMG3efhjSBH0
         pDeDcWZNnGUEVl+3gekEqSRdIibmmojZQuu0ztkstbSjOxdQ7e0ajl/oOBYJBCFES2Kh
         vTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647815; x=1724252615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ7nwNrJJ7BJlmzVGIzhqsZYBiUCrpKTHuGFi7YsVBU=;
        b=GtCAzE025ZXzfH6K2pkXlfUydjeM31Uhg7ULmewD9dYJfYtqi7lFW2t5M6LCpT3NQu
         RmPLnfGDHIPX5NSvU+yr4+S2CXaMUJlUib0B2D1+kE3vPqAPhqMzq/ahPB717sRTPmnd
         LAPT/R7JoHdLBJmNlxAikXNEl4QwIXijwc3IfeKtk2ooQ7c0j9CtZX1tmTNleBhAtLrm
         VG8U7Hy5ZohF50lU5QiiDim9cTT3H8VSg9Ur3KdLtc/3SWbjoljVEFJrEcCVKR7kVQla
         TzFhnQRa9qOjonutdmpUDZiq2QFteRUwO6crSQy4cYoOsAgixdHN/AdYqyyMAT8rOu7a
         9R3w==
X-Forwarded-Encrypted: i=1; AJvYcCUK+bv463gOkcoZ8IH0Buc2mzKtCBdK9G3mh93Ut7AFgMYJXHRfvP/nkXS66wgcArFT51mlZxVCDSLfFEuNPDJDZIebesgL0q5JOCNeqE5qmhFesyL7xwlQccp+QkxQUof/25SLFVUuZKS92no=
X-Gm-Message-State: AOJu0Yz/zN1LsFehapdoiG486vYGsyecDw002KkV6K0eG/sujLIar0Ay
	0tw5EBJW6eHw5Pscip9EkhvvvwLsQK0jywntg2F5lMLoOVQ3oMURtf7N3yrRrI5LHLrNedhVftN
	lz9lxD0fYYpPpbS7rMM4e8oECsfo=
X-Google-Smtp-Source: AGHT+IHLnwyEuvJlxyTpitTv+2ybQpHAwbksfcB7c88atDM2IVtNQkfJde6yhWIPgPzMQiZLKBGJ/oFk4RnBUnTn20M=
X-Received: by 2002:a17:90a:3f86:b0:2d3:bae5:87d with SMTP id
 98e67ed59e1d1-2d3bae5095cmr1092304a91.3.1723647814992; Wed, 14 Aug 2024
 08:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org>
 <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
 <Zryy04DvEsnxsRCj@pollux> <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com>
 <Zry1qwJnPDUtp2Nw@cassiopeiae> <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com>
 <Zry4iOGtR0nd6lNP@cassiopeiae>
In-Reply-To: <Zry4iOGtR0nd6lNP@cassiopeiae>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Aug 2024 17:03:21 +0200
Message-ID: <CANiq72nsSOaG=WhGP5GUQ=ygCh23iDQBc0kgjRP3B5MoF0CUjg@mail.gmail.com>
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:00=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> If we keep them, we'd consequently also need to add them for vrealloc() a=
nd
> kvrealloc(). But again, they don't do anything for us, and hence are more
> misleading than helpful IMO.

In general, they could do something (e.g. `noreturn`), perhaps in the futur=
e.

Apart from being potentially misleading, do we gain something by
removing them? I guess simplicity in the file, but it is also simpler
to keep them aligned to the C side (which I guess is Alice's point),
and avoids having to keep track of what could have a present or future
impact in `bindgen`.

Cheers,
Miguel

