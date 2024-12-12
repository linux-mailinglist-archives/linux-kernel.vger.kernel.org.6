Return-Path: <linux-kernel+bounces-442867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E89EE323
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B41887579
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D72A20E311;
	Thu, 12 Dec 2024 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dm/A1yj6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64AF20E30D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996101; cv=none; b=Wgzxz53xcyP5PFywZYyNjVTySgDqzu4yO0qx0isEkakHwsX2JTW+EUtOD9Tc6z1BTFStJnczsEsoArZg3BOfxCRsj3jw04BOjf+7tvXGnJL5wgBJ5x0wNRBg3Jxrz/bwdyBrtGRM0XiSG9gGauMGLg9YZMlwGnQJGvSf1SQqfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996101; c=relaxed/simple;
	bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YX/uevPII7ga4xCZchcWnomW+O/nJSHOv3hHVGFNn8wBE2/gNovUqMfVGa4n75lYC6KRaaOCDMg5bzIG7ZkCFpf3uPy9+gW2+7XVPrAeSbblTAHtU+2dFgez7esFt6hMDsbT6gQIOvf+tGi2CHzxwpcAWe2F8u6mNMBhztOBrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dm/A1yj6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so51694566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733996098; x=1734600898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
        b=dm/A1yj6i/bNJkGbkc7RTTAXe1u5S7qlb3bXU8SWdFKPl29E9HDHrfDZD0U32zTIzw
         jGXLRG4VKr0BNdok5TNMfjzD7ZbKZq4eW12x767WmqB3TGPRYanBIzRchWncrolt36ZP
         bLGyRTXrnEnQVgf70x5dGnkn7kiuZGyRjHhAmrCL51xvtOPHPAbN0Xn1zegl1xNngqqJ
         uLw6XbrKajB0Zn7dYtY/EU8UPoPHpKKFF2cMcVhsEPyP1v/lCQlaYH1p0KOR99o/WNKM
         BJkegtILYSXOzo49VfwV0vdn+0k9Qx+w6dh4SVcpUDj5UzF23ANOTeNcR/ep0QfD0wa4
         wBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996098; x=1734600898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
        b=PQc9X7lbgqV5/rz21kmljzX5wV7bjBxc1zBsCLHAcLf1Mu9mRXxn3nKW+dM2KuMGKi
         0hbcuOvamOdjXiZOBBXbooX6+x/OKkka4thEgV04ky0Tt6OWgtLdPy4QxvNomU4dbmgz
         uYs1drgXEiFDLTM2FapkLYgLEkPLHqB8jPhXJ+r/exGzkb4LXPxtp1zE5i/pEv3s5ddu
         6HQpVQhpcVB/4Eco7oYXfK0WtLrSmc4EIma5wxqGsSm0npUODVgWisnwt7Q8C2P4tuMA
         nr7cfJBMJLdbzSL+T6CTMvP1dtrlPmEDx5Xq7vgSKsWG8ELoT5B0R4Bk0F9dI3ZwTXAN
         A9/g==
X-Forwarded-Encrypted: i=1; AJvYcCUW9RfLD/u+lnUU0KioQnkq8Il5LwdUKDnQHGWAL6JCYFmM1WpcogmCRhG+XUfIQDe0QNv2ROncuTy0ztY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzthIiu3KLP6Nu9UPTGwDQh7zqBBhYg1LMmSdnKkYW/DDEIrRPN
	qpOHuCxA/oeCcCkpGiiU0VWMm1NMaAeMTEXgulBnT1quwPxeFm3kozCuW7KGu+uy8H2YsTdGuP4
	bCLkJN21hdzxZxlw51BNTYA0GdZtRNRno0G4O1Q==
X-Gm-Gg: ASbGncu4Nb5JpiFyNmSDq5sKw38q7vkFzsfAc7jmA84PBZ2XnnZ58pf+ZUA/Ox3nbKf
	Pqv12/dVzDP+KnZUG0NaI5W0aRecVna1CGxvp
X-Google-Smtp-Source: AGHT+IGjmOUF0dmAFvQ+spqIORx1VvFbP7DOU+11FOPHLYxp+IkPWpvwS4gEQHgdr928IyJxvQcPXfqsqgvUnrfIthM=
X-Received: by 2002:a17:906:1da9:b0:aa6:a33c:70a7 with SMTP id
 a640c23a62f3a-aa6c1d02831mr275658766b.49.1733996097955; Thu, 12 Dec 2024
 01:34:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
 <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com> <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
 <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
In-Reply-To: <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 10:34:47 +0100
Message-ID: <CAPjX3FdU1mOkRr+JVE+S4og4NvjFerZhHC_qupFBTgjn9=s8MA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Omar Sandoval <osandov@fb.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 10:14=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
> It got recently force pushed, 34725028ec5500018f1cb5bfd55c669c7bbf1346
> it is now, sorry.

Yeah, this looks very similar and it should fix the bug as well. In
fact the fix part looks exactly the same, I just also changed the
slab/stack allocation while you changed the atomic/refcount. But these
are unrelated, IIUC. I actually planned to split it into two patches
but David told me it's not necessary and I should send it as it is.

Just nitpicking about your patch, the subject says simplify while I
don't really see any simplification.
Also it does not mention the UAF bug leading to crashes it fixes,
missing the Fixes: and CC: stable tags.

What do we do now?

--nX

