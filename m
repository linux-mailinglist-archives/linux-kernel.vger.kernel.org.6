Return-Path: <linux-kernel+bounces-520663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53788A3ACEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5933D188C7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CA71DE2CD;
	Tue, 18 Feb 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBNUVquV"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2081A8F6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923085; cv=none; b=jM4oR85lKmcaxfEoYGbfTR9CF0JXK5GsXtJks6ihV1yXZMM8Gw8SANWGiG9fXT5Sg8q956AdiGw0sO0ZfhG0Y++MN4pRmfhxIYfbgSNJEjjQaoJBIilUOZnPrl/5nl7yCznfnfBr0HzDukC6H/U06CSXuXHVFzeXICOkkc9GAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923085; c=relaxed/simple;
	bh=fC1P3XC32NnXo00sjdLw5qb9N9oKkD+Omqv1rR0S5FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRpcu0aJkg9QtSCZL4UG0MRziSv7pNC5wZMw8ZkmT9oq7gW+BY5fVq66xGRF1EL56vm8UyOX0KdOuBs/vl3uCbSBY98Z5QHvgdc+tMr/MHifukpeW6DLj5L4y8u000rkeDe0peJQVeyRp0Qhqv+s8CC/zrngCXzNiDnealp/2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBNUVquV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb81285d33so641525266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739923082; x=1740527882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC1P3XC32NnXo00sjdLw5qb9N9oKkD+Omqv1rR0S5FE=;
        b=NBNUVquVCURmYfIOhIQBZb66QqzkBuPwjWuQlrKQj76FoFf4nD4fbz7YH+b54DgHmI
         9gzffI4yEv8u5+JD3GU2tPMxBQfzP4rSCXbSdc58LL1VYYOMbU3gjRQu4/Q0Vi7ojVVF
         mQXO8EEgmjppjMeXbIb0lSRNqK4aY1wDall22o9tMtof2ctiGSusLEcNFyaXeuzCD3g2
         vzkBgC2zVfrDJJX51ULE6cRUHsBl2B+fIGaiV6HFq9P1mD+5/B1tmsZU6mSVyMGDb8LA
         Amcu4r71c7MThFTUTbhhly0Dma3Zbkdhe5eySr9y8LFYtJzdkSOPF2eq4k9/0MtPtY7r
         XNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739923082; x=1740527882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fC1P3XC32NnXo00sjdLw5qb9N9oKkD+Omqv1rR0S5FE=;
        b=pP7NqZI5b7/pnl5tUrmrDxTQ4nvAbugMImxc6gkl23zcwglK3gjsE1VJbx5nxZwQa0
         riBB3MSDbKImZzQwxirKYRNp0SUA7ZE1kD5YyNR0DJodXlKjVqp4UDjNmWrf/knZo6gz
         PFrZANWStDTEhTf9b9q9GY9yRbDoOvLeZlx5xJUF7oprePAactr43cRqqW0glhbba/79
         pZw+x2QyqAZsQ5madc9zSY4UjuzlQynvWQBTLnFe4HnPqG0uqo702G6uG4EY//6fzpTL
         Co4IHQ2dkCai3FaVJSVGfVfATlf0iTHiDOzklhfXPV8YkHrf4EDl/lmZF4fctvIh7p60
         bz+A==
X-Forwarded-Encrypted: i=1; AJvYcCU067+/LLK90XkkBe4wRK3hFw7AoZItSrM0raUwRnFFpm3QYX+87YkfnhpueSteosb5KnoIChEDklJ7qbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTc1ByeTCn6tj0Np1aohLZhDnrpsw4YPHI/Dh0/0wkq7xSnOp8
	8mc77DvdPLRAZDiLonshvSUD2qfei2yvmmlr9WTiIG3/y87XPKhLbaQ5NKmirL71fdj1QJIqsh+
	fB/yEk0aLOY0V4ZjtpggtSMpoHsBqKfOuVxfQ
X-Gm-Gg: ASbGncsbL07eI9RX58MOwG4J0WbjmylMQWrXSkGpC2Kk05py1M9C7R9t6gBkBP36Utn
	yBJi3saTLmBaMOqk7SzIFXEvb39+jPiiVCXR81jRtOmvcK3vvneVzTt+sde+9+GcKyPJtwRb/
X-Google-Smtp-Source: AGHT+IFrQ15TJ33fdYF/oTMtbCii+ZRQfmSIkaWviOKdP/iHummReS5upGdEbovHEhto8hKzDWcCHzZn9/UWQZ+2rDM=
X-Received: by 2002:a17:907:60c9:b0:ab7:d361:11b4 with SMTP id
 a640c23a62f3a-abb70a7c9c4mr1630995466b.7.1739923081760; Tue, 18 Feb 2025
 15:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com> <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com> <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <c7894df2-2b27-4f67-b428-3eca312503f9@intel.com> <c2cf2184-7753-454e-ac99-8c4f3c9c3d16@intel.com>
 <01fc0997-a0e7-4086-b0aa-67b4a51b328a@intel.com> <12ed2ab1-e97d-4a20-8370-8c60cabffc77@intel.com>
 <ab2036d5-5b6f-4fa9-995a-fba63c0a5209@linux.intel.com> <f4d344de-70c2-4fd4-bb18-2912cf0f3f98@intel.com>
In-Reply-To: <f4d344de-70c2-4fd4-bb18-2912cf0f3f98@intel.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 18 Feb 2025 15:57:49 -0800
X-Gm-Features: AWEUYZlz10uZ3RgXyh6tsNf75k8mF_KZ5dIIh28yA3hngdsabEPbjxarUn5eOH0
Message-ID: <CAAH4kHYq7_3vLXQaCA7iKF+mC5Pg0cn-1FsB-iCbN7Jim9a-OQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Middleton <dan.middleton@linux.intel.com>, "Xing, Cedric" <cedric.xing@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 8:57=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/18/25 08:25, Dan Middleton wrote:
> > One common reason is to _identify the workload_ running in the VM.
> > Typically a VM attestation tells you that you booted to a clean state.
> > It is much more valuable to a Relying Party to know that they are
> > interacting
> > with a trusted application / workload.
> > Projects like CNCF Confidential Containers [1] and Attested Containers
> > [2] would like to do this.
>
> That's a _bit_ of a different story than the series author mentioned here=
:
>
>
> https://lore.kernel.org/all/be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.co=
m/
>
> It would be great to see a solid, consistent story about what the
> purpose of this series is when v2 is posted. As always, it would be even
> better if it was obvious that this is not tied to one vendor or one
> architecture.
>
> If there are actual end users who care about this, it would be great to
> see their acks on it as well.
>

We would like to have this for Google Confidential Space and Kubernetes Eng=
ine.

Acked-by: Dionna Glaze <dionnaglaze@google.com>


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

