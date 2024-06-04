Return-Path: <linux-kernel+bounces-200698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7928FB393
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097381C21A07
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBC3146A6B;
	Tue,  4 Jun 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="axaEJRhT"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76478144D23
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507393; cv=none; b=N1W6713j4P4ZgfISIPQSBkc9WwIUiB4ONo85lt35k6pwmwBcRCyJYmBv+OUBeVb4BOVwiu6+5me7H88DOZZrD8e77j+qYTUvcpZ9l0tIcHUI6KDnpawB6s0l1c1riNxHHzMu3jSzZ9JT7W9DIh+I4d8dPLAdhgixxj+gP3D+XEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507393; c=relaxed/simple;
	bh=OOpAIZhf7VAtMnJp97lf+JMAONnXTB09IET4RwPRDCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFXXG/kkey8sJreym0yEzkEz2dHqHFYaZsTaCRxcwUM5Shjkwzglw6KGICKpF+w8m0ZY7NTx9440mWF1D8PgXOF2on6lMOBcFgCtB2YVrZedayQQ8JQae3IoyJkXenksuKAn/A9dGo8Y3F/zqE7+Xfjlh6DjNcpDAo+myVR3IN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=axaEJRhT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a68b0a229so2174768a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717507389; x=1718112189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAbWUnTOBRaeWPYklSpI20QraPgo9d0o855WcgCKVIY=;
        b=axaEJRhT2kyfkVjA6WvAUJ+iKmMyJxLlcjaGY7HvsHEni88u7NjS0iiiRhHCZczSDe
         d9SZJTzSqrKKzt3tSqwoFugPwArjc9L5EG88E20jgWIaaQy48F67hCxvCS4epmtSNzU2
         XNDOvWgPU2nUp5JusWEZLv5RCUdL6XC2m7g3mYvURR3KI05KpN/6y1AZsC/xSEM9sGXY
         QM6S6P/wKJ2S3/oZQpLR+49zuuPmXeyZZRH4o3c3QtEa6Lk7Yh5tijr+rrgjC2EfMP3s
         bL9eKphHAioIA/X7jaRFW7exwbQA86jJVRaZ9zO67zxHOnj3oMzYgOCVIyWFN96CTFO2
         ynuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507389; x=1718112189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAbWUnTOBRaeWPYklSpI20QraPgo9d0o855WcgCKVIY=;
        b=hPf23eQAfhIqxbKu/febxjvLAcqjoUwO5iMvtRHmnVzuEvaQ4+pJolWAoSg70tz/UR
         VZcevE9jc8wVJOe5VBygHcCU4POoQ+6VBGHDM3wyUsfTWlvuLYQQa9LviBqWUNin1Tli
         R3OK81DITruHtwGXSP0pK2oz/LJ/NuhNiIiiRAKeCb67S8FLw3nMYMS/DLLhHngLZMcW
         j0WUmUjFM5hRcFapOhov/vmA4jSW55JDdFH3pzAGTRd83qhZFC6hC76F7EXvf7k+014C
         t8s67PVb/1LXd9yf2BLgsMZN8Us8D13Ccz8YijDrFzdYmjOCSmRKGY9EfTJiyX02M6yE
         Rnow==
X-Forwarded-Encrypted: i=1; AJvYcCWC1i3yN42sSnUEMNgJkp3boDf6NLtpQXvq1+TVB1TX+gYifOm3DdDTvOaF02pmkYospnXdL/yvWZhMGA7LPA3dfImSJSNdXAfqY1gJ
X-Gm-Message-State: AOJu0Yy+acYoGNRrQLvZog0iVTk0DR3TOO/Q6Hjh7Vxpsa5PSnOxWsRB
	h2SAXIDVxwISCo7J3Q09UkNyC9Dv9atUf0aziORBijBCeZZfqx/9L0EciK80NT9K/bMY1ZUihCn
	TLT45yNuZJoShI8y4M8R5HHRfyZUC2W/I83qQgg==
X-Google-Smtp-Source: AGHT+IHGGIMDZFU+gPynoc4Ujgj4qTVbZoLInIZYMo4VimoK30MrU/t+0tJSyI98tUhjB9Z3/I214BGwLD8bL8fSTko=
X-Received: by 2002:a17:907:7ea1:b0:a68:ea13:f68 with SMTP id
 a640c23a62f3a-a68ea131343mr538713166b.54.1717507388810; Tue, 04 Jun 2024
 06:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604090845.2182265-1-max.kellermann@ionos.com> <Zl8QW91FwZ9UpulZ@casper.infradead.org>
In-Reply-To: <Zl8QW91FwZ9UpulZ@casper.infradead.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 4 Jun 2024 15:22:57 +0200
Message-ID: <CAKPOu+8R_KUudoNNGM5m2q6oS0oGY3Hyc_7bKM+-DtFFjJicsg@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] Fast kernel headers: split linux/mm.h
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:02=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
> I am not a fan of these patches.  They will make it harder to work on
> the MM system.  We briefly discussed them at LSFMM and nobody was in
> favour of them.  I'm afraid you're shouting into the wind.

Thanks for letting me know, but I'm confused because similar patches
have been merged pretty often.

For a very weird example, look at commit adeb04362d74 ("kernel.h: Move
upper_*_bits() and lower_*_bits() to wordpart.h") which was submitted
on Feb 14th; and then look at
https://lore.kernel.org/lkml/20240209164027.2582906-34-max.kellermann@ionos=
.com/
- it's exactly the same patch, but I submitted it 5 days earlier, yet
the other one was merged.

Other recent examples (though without offending earlier patches from me):
- d186eb1ee885 ("cpumask: split out include/linux/cpumask_types.h")
- f7515d9fe8fc4 ("objtool: Add objtool_types.h")
- cb5a065b4ea9 ("headers/deps: mm: Split <linux/gfp_types.h> out of
<linux/gfp.h>")
- 50d91c765825 ("hrtimers: Split out hrtimer_types.h")
- 9983deb26d90 ("Split out irqflags_types.h")
- 6d5e9d636830 ("pid: Split out pid_types.h")
.... and so on ...

If there is a general agreement that nobody is in favor of these
patches, why are they merged when other people submit them?

Max

