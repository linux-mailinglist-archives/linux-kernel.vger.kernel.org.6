Return-Path: <linux-kernel+bounces-238279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085BF9247C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891B41F21679
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA212DD8E;
	Tue,  2 Jul 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qA596l9s"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581827E574
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946853; cv=none; b=d/6HTOZE7wjm610ar3SWxKPj4cxnxCXDzjKXIrFeOPdBjT1fljO8Z0dKyl1Y2DgSijbiWWy089+vbt457Bd4ikMnr5/SaD8qLQfCv5CprpEfFR3xtn7lOEMn3g0RDjnpuaJV2ZQmSntdx74RJH5s06mdPwGmDbzYmkMlMI+FP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946853; c=relaxed/simple;
	bh=Og7DW5Yu4GR5oFkUrZTTWI8AIavBfgW62M8Yq5VQPiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2fVNcvDhJajiegLbbaw0tXD/HtUd8Rr3qms8xpm/6zDxDK87Cti731mtH4B6tpxJILMHxZe4Ux9z2NTDDsZ28aJPLniXQdiMFBzsnCIM9eYWxTUDHgWwI3M69dIFdo5QXXBC3kizoGHF0w+MZy8t4ofG0HHTGWm6J4bxtTE5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qA596l9s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6fe81a5838so441497866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719946851; x=1720551651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og7DW5Yu4GR5oFkUrZTTWI8AIavBfgW62M8Yq5VQPiA=;
        b=qA596l9sQhdhNB4+3YdvUXfWKDIkdoabdE7qi8Il5VJtm5LzuiAwbLQkuLlt7oL8lO
         qd9TLbYV7lJgKWNOuVTgtThsjsrY890H2lKjRFlBWWQP37WnU6qBBjEQ3szGQS/xUDGQ
         +bNRmFEEYZ/EajSPYGF4b+jZ0PFT29U3mUyzV2wPaeNnR4Ekl47bq23yNeQFclGhdfy/
         AsZ6+iihdyxZNPFMJ8qO4ZTbRKAeXXkaTK7t8KhNY3TkJA+Wl2IkcC/NFFmz1thJbDFC
         4CW40Iqde+grFthx5tsVRXogRSsfCPY8MjlX9aAZbJ0ZCGjJXpoXCCo+OPGhmI02RGNe
         LVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946851; x=1720551651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og7DW5Yu4GR5oFkUrZTTWI8AIavBfgW62M8Yq5VQPiA=;
        b=S6vp8rJSMs9H0VEQ2ABghrnUM7B11f7H/dbQmZUOeM6lXs1JKeFK15jJIVXcoWLDeL
         JxwfdrCX30mhk6+hHMcRNrFjAHQIPeskk0ikOJBIjO5RDVO34EXM+4iyqxHnFws6WmsF
         tG5SMS5hVb9wxl7AO+zn9dgGWf/W/lHGqLGhGOLoFERtIWp62tN4GdCVGXqlnWMAnE6a
         aQH+81szsX6UTGWUB5SXPvkiqr9ClQdO63zI5MgHgIIs+V4GnmFUmzUxEfGArL7I5ow7
         7rMcDzsvrDgIRBBrrFx0s4QJgMCuMeWNWO99NlYgbGp7wUK/t4OxrzpMzugKS4Y2TX8R
         kB4g==
X-Forwarded-Encrypted: i=1; AJvYcCXwb9TDmmulEh4ZfaS9SNkFVfkKJMLX//M8zGfSF2PPUnqJJ/cqINDjQXHhkES4Lk8T740FBHgLhxyAGwPjRovfWuZCfknVk7ml+Ziu
X-Gm-Message-State: AOJu0YwlV8wKnVOxEHoIzBG42/vY5u/eRsqKK/Ii9uqy8bUAi1eGXDIa
	ZHCylwu/S/1PZmTTRWjrGViR0JajK9n7/tN4ZdiAWrQp8dRkS4tL0vma0qh+KHo7i+D5JLQ2I5g
	EhETBZK79AhdPqDpiFaVib3k6CW02imo6O7a9
X-Google-Smtp-Source: AGHT+IEtU90GXT6EOoRx2J1TTgr3l1xux+l3ChvX/U/M2rL9K7531nZLNavqx6y3ZQVJfxLYpJCq+2GdoOshT8YxfBI=
X-Received: by 2002:a17:907:3d8f:b0:a72:4bf2:e16 with SMTP id
 a640c23a62f3a-a7514463114mr781223866b.16.1719946850169; Tue, 02 Jul 2024
 12:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702132139.3332013-1-yosryahmed@google.com>
 <20240702132139.3332013-2-yosryahmed@google.com> <20240702185835.GIZoRN297EJA0QgBDC@fat_crate.local>
In-Reply-To: <20240702185835.GIZoRN297EJA0QgBDC@fat_crate.local>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 2 Jul 2024 12:00:14 -0700
Message-ID: <CAJD7tkak-FdHB0X+xbNxRd6uXS6v-6KYWugJEpwvu2upC88dgQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:58=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Jul 02, 2024 at 01:21:37PM +0000, Yosry Ahmed wrote:
> > Change-Id: I7fd573a9db5fe5284d69bc46f9b3758f1f9fb467
>
> What do those tags mean?

Those are gerrit tags (from internal tooling) that I mistakenly
included, please ignore them. I can resend the patches without them if
needed. Sorry about that.

