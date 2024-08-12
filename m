Return-Path: <linux-kernel+bounces-283652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F494F759
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C2F285D14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3318EFF0;
	Mon, 12 Aug 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9jcJ9Qe"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0ECC156
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489972; cv=none; b=coRELS4hkQ7yLB5wPxwWpx/XxceC/OPoXVEitulB4e7q/lNbSZPAkeBrGVZxGD2LpOjH2Hz2/JaC86zxWbQ7zRNl7SQEmSwcLKgIneSPxTZN7xxCPPtDLL+Szc8GmUTF70iATI7zOySjhS4ABk9WO/oQpj81i6clH/Pc/KzCdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489972; c=relaxed/simple;
	bh=kgpQE/kgEgLmEtm1pA3/0VLjaGDLYhBIiuxSNUtHkIo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rkUs/7lpePCMDMWWZvAj5370IEF1bKr3SL7Q3L1qjx5eP5SvifcZ3KaspXUUkV+3ZaqjozGLZ80aGnvsyRUO8s00zj6OePB9xICoiF3AtelP+81M9wst8XX/jC7lQhL5i0UrC7ae0oLpSt2QiQI9M72QQsM5XiAVLakO4tqjmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9jcJ9Qe; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso389436066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489969; x=1724094769; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgpQE/kgEgLmEtm1pA3/0VLjaGDLYhBIiuxSNUtHkIo=;
        b=i9jcJ9QeTpd1O/jvz28wsnmzJe+vcdy4DGlcSLgKPpMxe4cFrpSr/TrPx0nFB/mbzm
         OarlOYBS93eKVAOOnYWG+VOYhqvU0ZV7p0B18rqfYSjoPiY2oD3uUpL89eVZPebOzK3y
         3aWgLcXbatvAtfE4KziC0+zK6ciUD/lfREI65SIGQCJr5UEG4irUPVDmwsgBBV9mLTxj
         QTRfpv8LZv5d5rfWMWK7t648cM9yKzE7XJbnfOH8mmjiEd2M4o1OfiXKtJzd0ZqPTIY+
         xxGcInIVDslCZSLyQrM03sVghwEEdg53wZH/uvmmbPPR0toJoQ4n1qsEpVLj9Fl3lX4s
         Wfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489969; x=1724094769;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgpQE/kgEgLmEtm1pA3/0VLjaGDLYhBIiuxSNUtHkIo=;
        b=VIFAC1DjcNx2csxdJZ+UoWx+mlDARqyeCnLd/wHwReU+kI/ny2gTBce35dxR1HPsM5
         DaFi30CYphWyMb/02eJNzDkvOGkKfiNFCdKnOOyEWcpITpnAvNVO05I9PC0toToLG2Nt
         oaiWzLOayRQDm54rQNeZO8Fcn1bwbTa+KWyvYenqmVPSUG2RFaHiPRVxZQ77ZGaEKBg8
         64a/BfK44E3nsRiy3F1hqVT2ii+NtxHWzCeiNtutLOskSmF74cblDZB/XCdVBm5fmzWp
         n0MSIgKQuGkcuKWPLlLOoOBbCSMLC5jMYfJGC+q8oPuLig/KcyNl0xE/MKkl8FMmhbZT
         3vqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEBk4fTL+vwYUTR99115hxIP6Mij9dbmgP0mxxWC+EfBKp4SJswbxAKWwVJNqknEiLrjglII9YcUVu02Eg16Uudi+NO7y+6kBP3FRI
X-Gm-Message-State: AOJu0YzpjvKBMFg0aHwAnhM+6LYTHP9T6N1sOxas0WbR2IBCoCkXqOKG
	RN23OIicYFor+D5zwyr9s6jtrvJPvrTIzBdgpBSk02qQUxv4bsqj
X-Google-Smtp-Source: AGHT+IEgo2OIYxg0EiVPhq5E93jXkNiu9cnqV64ICTgp2IPC98lUZjnB9NOnd7bQm2haaO/nzVdcXA==
X-Received: by 2002:a17:907:2d11:b0:a6f:b98e:9aa4 with SMTP id a640c23a62f3a-a80ed2d6ef8mr87563166b.61.1723489968651;
        Mon, 12 Aug 2024 12:12:48 -0700 (PDT)
Received: from smtpclient.apple ([132.68.46.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e555sm2511166b.160.2024.08.12.12.12.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2024 12:12:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH v2 3/4] percpu: Repurpose __percpu tag as a named
 address space qualifier
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20240812115945.484051-4-ubizjak@gmail.com>
Date: Mon, 12 Aug 2024 22:12:36 +0300
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>,
 Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <74B42046-E39E-4068-A6CB-F3315A702285@gmail.com>
References: <20240812115945.484051-1-ubizjak@gmail.com>
 <20240812115945.484051-4-ubizjak@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On 12 Aug 2024, at 14:57, Uros Bizjak <ubizjak@gmail.com> wrote:
>=20
> +#define per_cpu_qual /* nothing */

I wouldn't do that (the =E2=80=9C/* nothing */=E2=80=9C part). It might =
cause a mess
unnecessarily is used with a comment.


