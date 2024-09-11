Return-Path: <linux-kernel+bounces-325583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABD975BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636A91C22291
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1E1BBBD2;
	Wed, 11 Sep 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu23TnYP"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9B1BBBCB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086321; cv=none; b=RTf8rPNHJRarpp7nTlg3LYCDyEBSk3Pnm0QBMWcFtbBElCJ3hJLJ5HLKoJ+ZyE+21o1ZaCTCqG2syKEelkXFD5JmViAcdyRzLUfKzn3iUXD38Fsi8zgHnGkxjHOP1wlMENz0FKAqMoHayiFV4oJgcChiWZnMOMtbltJDwIdVBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086321; c=relaxed/simple;
	bh=vA7u+UZJCFjVYkHzh9rRqVi/HTXF1QCq70f2BOwy1Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABODltF62PIgnCv8bObBW4iJ00LYkAleGa4gOmo5aWUOAjD0UKN8229OZjIBHEsNa08mwlywoV9IHkxqxyCDqDFExyGuFZslmAfHKdf1dBqdlfxNr0hQ4vcwwjtrbMRwzJW/sc4M+LUH6pqzzmv3Mi7edoK/0VjYtoSCLLHZePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nu23TnYP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so30383966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086317; x=1726691117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA7u+UZJCFjVYkHzh9rRqVi/HTXF1QCq70f2BOwy1Rk=;
        b=Nu23TnYP27d09xVXdL3O8USoIL42HV5QDrMrIvYQpFWsCg7O3xAHJQnq+c52vEBsvv
         7DJZiyeBT7+7AdP27EBP+q5w16YKBta6kO0AGkdK/d9ILUOauPnksS5AbtGBd8NtHA97
         Nq/Z4hMO3a0uUWFytu131bweEwGS/Y8HRolTg0xHFr9VqgG5qrvifIPIHI1swjWZpS/J
         WyROvnTMhHvxv4kgPGDEY4pGjSPfCGzkEMLOwjQQbzJm3vdGU2bTrQMW5Gw16SfwawtH
         AjCHUL/xStYjeZ56PPQqKKFrtMDIl60oUTHe0JIkPpv2h0q4caEWAAkqZLMUncXNDEQ4
         FTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086317; x=1726691117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA7u+UZJCFjVYkHzh9rRqVi/HTXF1QCq70f2BOwy1Rk=;
        b=NYn6qVeHaM2Wk/n5D+zQFEgIdTWfTyoJd+CEeeTBpVS9fVSvs1UJX8T2yzLEiQaOoC
         osYlDqdvPhpayOkpo2gOoYh/6CKj8M9/huv2HsSJd+VkxNp0fb0eq3oypAOMx95/9kCE
         M7FjX8ASAYQZJSVzq7flpCTCyF0pDVmN4uxr2UKEUQHwsqHUsPjK7VBsQ4lFp1JzUc1P
         RoPeYp33Pl/dMbK3x6s7XDcOyE4Ms8F0hXXyXRlwtsyX7wbQxjQjW95ML2N2h6vrJCNx
         D3F87qOPu4adXvjr1CNJkN/tDFkPzXmIr5RvGTZ5OYy6AIjlWQ2ofrxPVPuZMIAdE6WK
         l2sA==
X-Forwarded-Encrypted: i=1; AJvYcCUBZFdddmAEcMN+dglCvKiFv5fQ3JevgHQcj9GoWxW7BpG7kc2tMThJxt9wJEVmZ1aRF90uCMdbFeSu6L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBdrlvqoUuAQud/A6GMOLGcUiBIwfvdpXkmXeNiAAnJyLW0qcV
	VltXIjOOZSyXgEaN74OjGDymLGuFFMjcwz1pXBJs58HigkDiXF1WkDp7BZ5/6WZGEsfJMABNEHf
	UZfqPMHCF5TYoFk61O0kLdtEpAGjFynyoNo8=
X-Google-Smtp-Source: AGHT+IFMjRe77yFuysdfaosrC8DOmjCWlZJ2RFEl5VdqH/ls60M/dHZlo0e2StLsun7t07Y99I8+FEnKM3PFKoVIoZ4=
X-Received: by 2002:a17:906:d7c7:b0:a7d:e5b1:bf65 with SMTP id
 a640c23a62f3a-a902943596emr54029066b.21.1726086317086; Wed, 11 Sep 2024
 13:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-9-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-9-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:25:04 -0700
Message-ID: <CANDhNCpAOQvUEg1SSqmdLevH6JrnFnu5qib8p7zygt8LFcCgYA@mail.gmail.com>
Subject: Re: [PATCH 09/21] ntp: Move tick_stat* into ntp_data
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Continue the conversion from static variables to struct based data.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

No objection on this, but I wonder if it might be worth dropping the
time_ prefix when you've moved the fields into the ntp_data structure?

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

