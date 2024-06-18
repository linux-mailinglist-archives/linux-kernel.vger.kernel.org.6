Return-Path: <linux-kernel+bounces-218865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C93590C726
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193E8B218A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D721AC228;
	Tue, 18 Jun 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrYJIaUe"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5AF19F496;
	Tue, 18 Jun 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699478; cv=none; b=SP5JB4DkT5r+npbHI7HXuuluFHk+tF8ZVimkGHNp6FAgYOb1zfTokRuUNaIZZoNda7Dy+qv8nPIDLsxNGERpDoZHferBo9bsa0f+puTCjAReECHFfpKuZUfhijkZ6nSgWiM9cCm29ykcDgkAWZbaJmQJp/P9XOwgccp3YmVjB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699478; c=relaxed/simple;
	bh=LcpTTRTfS5LkKlaT2xsUTd0pWn/fr7vvmKAfJCXkyjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVnvbYVPMtQkdzWrwqCAj2/hsIxD6Ut/NHRewdBRFVRwvh89uwiSBHCckXnMDT/hbjo0OLIiQ+o1P2gnXUdpA9Oxk53A4HII8WbfXNyvci8xByrYaQ2ZmeRwuk03RDa+ljqqVZatPNVgtst+DmPLLmII3JVO3CVP8RZBZFD8kVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrYJIaUe; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso4303447a12.2;
        Tue, 18 Jun 2024 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718699476; x=1719304276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N18gaKSY5xzchREG42esnR3ZJkUD/at7qWWDDlXqO4=;
        b=TrYJIaUenl8X52eCgztlBN/M1VpOvxUfR9UObadWkJwuWNPQJ+otquhSzua0PXFmD7
         Og1pnXrYsUueVUh+2gpOQW3iSGICQkAnB3nI8H6HHowoWHWfZylLOIEI5FiGozbpE6Hn
         POdSc1XRyAqtnQVc+J+TC13CggvARMwkjlYGHkAyMWYjKRCbZB4BVJKMZpDLj7O5ZlD+
         PSAQ76ZLm3N5fFh9sVDDtBbBQF4TpfKNuh5RpirtFy1PKOJviognaIAe6Xi6M7KjTUdJ
         Rp5u9K68zh5d3D+wyCa4VUvzBnsBx+YrAwtCAVvVoTWD5BNadFo0gB6vHMZ08CbIlgzW
         ufaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699476; x=1719304276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0N18gaKSY5xzchREG42esnR3ZJkUD/at7qWWDDlXqO4=;
        b=SMyPl4RiIYbg37VWGxCD6rftftk4esSRIekdU69+eZHueR/4guoey9/Nr/Y0ZITRmY
         TdtlSRXKdFtFILxhumF1yo3xlyK7sJwSsbu8owqsRAZQLqbUGZsXSNMNADfT4gQhl1hK
         kosvwWvFaukxvoj9zfCpxgTJdN4aKT0p1MI+HP8ZkQU/kAWA9mWsLnZ7lGncQhCAhB/f
         iNukqHdQ8ux4jJHLX+QvjewjPWVXX8lYylT88Ij865GormMulvUg+FwMeteR2yDepdyQ
         7U2uX7tCMD+ooW8O1j5T9V4WUFYumGZJ73kq89BEn7/3IfEj5CoZwN5aUQMKUEqQrYiV
         i/WA==
X-Forwarded-Encrypted: i=1; AJvYcCXRTHbF/deinCVQLC6w1psCsTWSgg19Uc3vXixV24wwXzE78LRORtyCCuo9gUQjpy57iKy6IHWI4BdARhtPHpHX8vM6xHJxEs5gfKLTulLuwtcn9VjaEud+tnXzu/kFD65GqpWqzwa/bAsVUSc=
X-Gm-Message-State: AOJu0YyyNajewVmUCE2FP/zDMd47M+E3bhkj0txN8K+qZyxeBeWHuvy7
	Z9Uy9I1xpXZpuDe0zIRD32fk/c/t2JtVe1rBIoEvpJsu7qdjd3FAYitD3lnoc5Rb8K1/N1Sjrsx
	yZcm/MwXCELakAKtcNX7i4oyEdo4=
X-Google-Smtp-Source: AGHT+IGIsdl0GFjOJQXvNV2rKGlS18lw1WiDrFuxbT/zOVrAAUgUyCTmyKQxkEkJfE2O/ZydOP/DmHR5nFUt/fIe5Ng=
X-Received: by 2002:a17:90b:4a51:b0:2bf:8fbf:e4c7 with SMTP id
 98e67ed59e1d1-2c4db242694mr11733858a91.16.1718699475911; Tue, 18 Jun 2024
 01:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617203010.101452-1-dakr@redhat.com> <20240617203010.101452-2-dakr@redhat.com>
 <2024061823-judo-overhang-eeb1@gregkh> <2024061819-deprecate-bladder-8639@gregkh>
In-Reply-To: <2024061819-deprecate-bladder-8639@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Jun 2024 10:31:03 +0200
Message-ID: <CANiq72kwROB8=HdmcbU49csAixKZkxfUUry7umZbpzPRUZ+3BA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: add abstraction for struct device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@redhat.com>, rafael@kernel.org, mcgrof@kernel.org, 
	russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 7:32=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Wait, I should just take this in my driver-core tree, right?  Any

That would be ideal, yeah. Thanks!

> objections for me taking both of these there now for 6.11-rc1 inclusion?

Perhaps give it a couple days to see if any last minute feedback comes
(and given Boqun's in 2/2, I think Danilo may want to send a quick
v4).

Cheers,
Miguel

