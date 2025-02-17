Return-Path: <linux-kernel+bounces-518140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DBA38A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB413B380D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07202229B05;
	Mon, 17 Feb 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hqri5vQf"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D922576E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812847; cv=none; b=H7T9+bpuqQ9ZX67u82plAvA/6IzxbPmaK5fsUjwBRW9Kt50BEHQvwzYQWn3qm9REonZ/bL74PIcIA3NqZC/EvrOBdy/bUEqOtbwMAv4UPBHFrDS/FX3XhvcYEwrh4Eohdi/WQ6hDBUqmCH7NelZsWL8E+q9nBU+JkYX/c1vRqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812847; c=relaxed/simple;
	bh=KitNqb1hNItZph35zvXtWR51tXJ70TMYSOy5bT0CeFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4DdC56pgehtve3FJXHnkVGDW2u+mM+vmtFnpPXsuV+z4kHgrDcKLjUkhxTF8FLVvBbUbX8N9OblrbrRTd8lXO12SG5gnQDr310F29Fk2ST00DE0VzRaraFs0BQzI0oaxsgqZ4SU2dV8gWA9ExHjNpRq4SECzavN1X4/d9iB3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hqri5vQf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471f1dd5b80so231131cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739812845; x=1740417645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KitNqb1hNItZph35zvXtWR51tXJ70TMYSOy5bT0CeFE=;
        b=Hqri5vQfE6X4CmbPI+wat/XNcpXNIfrMSsPUyM7hEWS4BjROAc9RDS0INUy9TTmedU
         Kfmwxny0sh9P6lVvPYW8haRcBySc+mMNNRoSk0e0BY68Z7kjGagTSioTicAgkfh5lSyU
         10G2BIs/qMWCiVW5IAjWmM55ZfwgMoc2iY3vp4UuzZTHSU0UkvoFAnmai9BUCp/tuUmP
         Ik7Zc0um6co1yT9/lMneHHpks8agb1WJKnSrTeMZ+HvMGmmZgn+MWeiqp+HqZvrysf/Z
         PLQ9ZDhhJT3ve12eGid2trM67y5v8QXX+OQ0iIWC5CnE9ifk4vE9ir0wTa5Tb//887Sj
         PWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739812845; x=1740417645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KitNqb1hNItZph35zvXtWR51tXJ70TMYSOy5bT0CeFE=;
        b=lZlKkO4DKn21CNwKS9hZRyzMILWx06n8oP8Uev/Htvjc4AblQjnLxubnAz7POThK9p
         PMeJ4sA5eJ+fgbHDzAd7y61VDXmmRvvjqunwEAI7X8tVaME/HB8Bm5eSF8sihYf8907I
         JD931Q8IOWv2NJTAL0pfLDXfaWnI0DgJp6MK7zFGuUqzSYSVsZH0zMnoCUR7Uee4EH2u
         OTY3kybz57RhBmnIIApca/8wPOSQHCHAghb3KOAGtzcN/z+aRCl4U5WzAHcK26RwrFTu
         oKEaTMS+j1YgZc9c4Xq9PCP6soJ7Kj33oaFD6Hc5pXdWzr5yIZRw5oc98GQHUoHZM3AV
         ol4w==
X-Forwarded-Encrypted: i=1; AJvYcCV2EkpXYWSjofyn3HBr21FloUjWKZHBuIbGn+YXaUzcownXqKumkSmSAfr08pZ1P6u5yNYG5ZXTs1EgD68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeA5LNPoDkioF8i8/CcHt5E6Iom2p3+2tdDrjVjpP6O56MPsVH
	sRu0mX8oH7lEo8WD38DENhIBYZBHHFbiBhqkplyf0rwiAUmml6YVXsq6o4TouQp9pbcRZ7D70fR
	bjI+A5vD3bmayfIufscHr7sIVSMVf+6Q/QGP8
X-Gm-Gg: ASbGncu/p/OVpdLcAo1jydBH5M4foeYqRyyqEO0g/j7MRcQ0gkC/Hk4P6wJDy6hNSnx
	Gkrc4SGpEZ3t8Vcurid24R5/KcbAld8MeZKQ3VCNzDCfMk9S3row3AhgP120s1PZyus3uVzxqst
	HXXrJ8xNGMadfda1I2bl0CMDu7vw0=
X-Google-Smtp-Source: AGHT+IHtSBo94EPpnG7ESdGyKa6VP68eV3ZrRwK4VaJPxYG/Im2Y0ZICU1JdsATecA8kZWmkgxucfSYewavfDnZgqnA=
X-Received: by 2002:a05:622a:22a6:b0:466:8f39:fc93 with SMTP id
 d75a77b69052e-471dde5f57fmr7315731cf.3.1739812844746; Mon, 17 Feb 2025
 09:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-3-5637b337b443@google.com> <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
 <CA+i-1C3fetiBYVbfpAbQEAnogzdza25pu2DosCiTT9YkXwt0yw@mail.gmail.com> <20250217170817.GGZ7NtAf-mg-zySpdP@fat_crate.local>
In-Reply-To: <20250217170817.GGZ7NtAf-mg-zySpdP@fat_crate.local>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 17 Feb 2025 18:20:33 +0100
X-Gm-Features: AWEUYZlSXLSAfoE9pg28Ca8tCxl2r2aeCJtImtIUaZOuCIeuoNl_kBUKnQ8H2SI
Message-ID: <CA+i-1C0=tDMpfZqNq0aWns=cj70UOOmCAPOonmJi+MM7B6G9Kg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/3] x86/cpu: Enable modifying bug flags with {clear,set}puid
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 18:08, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 17, 2025 at 05:56:32PM +0100, Brendan Jackman wrote:
> > Er, hold on, what chunk can be whacked? Do you mean delete the ability
> > to set clearcpuid by number? There are still features with no name.
>
> Really, which ones?

I just mean the ones without a "name" in cpufeatures.h, e.g.

#define X86_FEATURE_MSR_SPEC_CTRL ( 7*32+16) /* MSR SPEC_CTRL is implemented */

> Are you saying you want to turn off *arbitrary* features? Not only what gets
> advertized in /proc/cpuinfo?

You can already clear arbitrary ones with clearcpuid.

But for bugs, they all have a name. I was thinking that this was
because they are defined by the kernel, that's what I meant by "It t
doesn't make sense for a bug not to have a name", although now I think
about it we could totally have a bug and not give it a user-visible
name if we wanted to.

Anyway, still think the current logic is what we want here:

- The new setcpuid should be consistent with the existing clearcpuid,
i.e. accept numbers for the same things clearcpuid does.

- There are currently no bugs without names so for those, require the
string for both setcpuid and clearcpuid. If we wanted to we could add
number support later.

