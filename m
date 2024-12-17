Return-Path: <linux-kernel+bounces-449542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4349F5099
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E0516EAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327BE1FECA2;
	Tue, 17 Dec 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRZleV7S"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6651FF609
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451221; cv=none; b=WUceeXtG7g9harabb4xb3r5RL5ln7LUnYxN19DYOzSqnQ+j/l7vxgvE9zrdaGkHR+k3dR+Cu9Qgk/manFYs0cr+WPTPbjl/TYaz3U0JiNmpLMyefk+mFDQebOJzs+25S2wRbILvseOmFT+EiJTe61sgEn0LDUt9qvnOAvfTASdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451221; c=relaxed/simple;
	bh=yMkXhimHSNgkCBtW6GdCu0qlZ/ulIAiC5pNf9JbKmis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMiwiXAaiO/ws7Q2Zi40MCrvPem4rwhbIUshzE+tnoCc6XhOw7mywmxZsAv6X5Ru3wHiPm9WBCvpjbBzuPjwQWytAq3uGYnKyykoYP77gX3ITD+aL/aLjupDzT6r+V9OpeKId4bmnffn75PXLtFfQoc/ZYOolr4/+u9kOS8vNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRZleV7S; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so7187083a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734451218; x=1735056018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMkXhimHSNgkCBtW6GdCu0qlZ/ulIAiC5pNf9JbKmis=;
        b=FRZleV7S6N3uH8R+za9DNTKgPyMOScy6hJa1YLIVyflfthbswn65RvKJbCX7CLE0Cy
         Yy46jrOP3RVTLHCoBof0LJ1aAc+O5WX8xSndxJqKP/fBkF5yJeBMZSPSsRvY9bbgDLQS
         Xu5hTwIOU7dwlEU3Phn8MRVJCOohNC4/OrWy1WFMLNxHGDR2hSknzvr6CMRd+kO9FQSB
         Mw4sAcmZ9DKckUJBkJVLgkkR+ojddp8eh2cgntxE5z91TmF+MqqbXj5QyipXtK4afWbu
         s1o+Qanq+de/wkzRfZD8Uk6geWArpdyTkUx/7PTaogmD9d4y1zuiLuwE88SCgM6ri9WV
         NlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451218; x=1735056018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMkXhimHSNgkCBtW6GdCu0qlZ/ulIAiC5pNf9JbKmis=;
        b=PliMkQOT4Xg4JNOOAEgYVlE98I8RklwiZvGSlp5onHakijy/CL8AiSP6QXVRnI/82o
         2B9sXa08qPxDfVSjRmGFn0MnNBqN79vKsxVHeHCZ0nIdQ4YXIyGpCzxoMNGVOFQIpQrx
         zpacOGbEMdBdZl3M1eLQxyIMLuSdEWvUOCGThKNrAs2ptJHuV02CWV5IUzmvMcgaOxBD
         kUfFSvpI/6q0QVbtO4wm8KyZIkNfRkLGg+NXqC7RY0L9dwsZ9uWs6Km+NMUksDX9t2eh
         d0lOfcgZB2AodEC+IcclXfWjTuuhCoAIInBoGCKGuqC25+VE3v+xiKBpq9KP5lB6pKUv
         tKMw==
X-Forwarded-Encrypted: i=1; AJvYcCX1fiG25rAegEM5yn836jzw2Y1MaIR4WshYVXZd5ts+MdZfR8hCh8ZvhUv1J/0f2sMZN8BfIwZZuHLfGxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lU9tYYwewtkiI5YsE/ijEqeRRmIWYSONrT4h/6CoOxRAvq+J
	lh9UuagZu/+GCCHb9gmBGtf95A7d3cKIdEHV3m7E3x+G/AK2rdzJwm9HTRcj9ILIoZzWkg7Ji+y
	XBjXuLZVkwjW1CXCJAp8VO/7eF9quQVfGMlkT
X-Gm-Gg: ASbGncuzu82eEtt9Y2QTpDBiGXzP42tKVzGnfdsEOkeTk9o3FnxVXTCudVe+6mm2O2Z
	DlXd39Hf2oULQPClnMkU+3Lmoa4DfSGRlWHuqtQ==
X-Google-Smtp-Source: AGHT+IFNZC7Hw++tMkFStafWWMV/GkZvsv2xsoec16XXjJA34YsckivhWJKovnlU3n2/vwLA3YFKSwnXRytZtX+iWQc=
X-Received: by 2002:a05:6402:5415:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5d63c3dbc28mr38182350a12.23.1734451217876; Tue, 17 Dec 2024
 08:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734392473.git.ashish.kalra@amd.com>
In-Reply-To: <cover.1734392473.git.ashish.kalra@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 17 Dec 2024 08:00:06 -0800
X-Gm-Features: AbW1kvYYZJqPhmb3aGCl1ViLv-OIblMbuwwguLZErK06_FPk8Pypubp8GuwTI4k
Message-ID: <CAAH4kHa2msL_gvk12h_qv9h2M43hVKQQaaYeEXV14=R3VtqsPg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Move initializing SEV/SNP functionality to KVM
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, michael.roth@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:57=E2=80=AFPM Ashish Kalra <Ashish.Kalra@amd.com>=
 wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>

> The on-demand SEV initialization support requires a fix in QEMU to
> remove check for SEV initialization to be done prior to launching
> SEV/SEV-ES VMs.
> NOTE: With the above fix for QEMU, older QEMU versions will be broken
> with respect to launching SEV/SEV-ES VMs with the newer kernel/KVM as
> older QEMU versions require SEV initialization to be done before
> launching SEV/SEV-ES VMs.
>

I don't think this is okay. I think you need to introduce a KVM
capability to switch over to the new way of initializing SEV VMs and
deprecate the old way so it doesn't need to be supported for any new
additions to the interface.


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

