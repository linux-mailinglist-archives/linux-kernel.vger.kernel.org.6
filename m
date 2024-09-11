Return-Path: <linux-kernel+bounces-325580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1B975BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD011C225A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4F91BB698;
	Wed, 11 Sep 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mte2mOay"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80B1BAEDF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086251; cv=none; b=fvF7D6mKpeJb/aUTusWeYaLMEHia+980xtYsBJtTs/pfAkw8857oiqDyHz4Wgtcw2qlOv7UJVij0PGWqCqPpvFrkP4iIwZ53GLYmPJ+Hseg4BTU3TEh2kdxS3F+XgEwLTRifajKADff6YunHjfnSRNqsb4BTQB0Cors8BYXXKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086251; c=relaxed/simple;
	bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/+EcfwkIf01kya0Jo3YXvJ7c2X8eLTTSVPQxvLSuQuZ4ornZPXBUyXLwBKq1jVuSKF+fum78uoh2kQE0cdPBe8Q5HxJLUaHc19ahlLxx27o21kwyz4bIbrvjRTC7pjkEfsqdcRsb7MuanvWbeLRaNbjVj+rWcbG/xS4G4C05Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mte2mOay; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so226591e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086248; x=1726691048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
        b=Mte2mOay+G/EbCZ/OGKyDKHs5jH4R7UiY+YG7dJ6wd5rXB1nXygNDGXun3QyNYWMlI
         s/LW8V2WtYvN/eYV9GriZSrN8clWJO7fQOMcKdnkebkn5ktPL/PwuCKG/GNOfjDNmUhT
         X7BSauC41wx2HCUuetnVUZH1pSUtocVb+XdZRhMg4OwJnD73KBFlevNCf4c1X2407Xpf
         9fy+vD9ai9MZBlxJFigzZ3IwWjLPWFR0ETuKylWuM18BV0UrwBQgNw73fp+Qpy58Oxyi
         28M09XRQKr5C5ufu5y3fmbfYX3W4UAQu4sKAUwFXxLIPTNocsP6ooG5mnlqRyWgnIbCl
         CzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086248; x=1726691048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
        b=pKZcBYwgkMUjFRu+kdG7OOThWLDZMIsEw8teJpN0xpSAVwKOh8WNPHJK7XsCz6sA0R
         rGIl9mlirscaNi+StMuQMGSDeFfjHznjcWvOaalXrWyuDufuy8drAvBkzQqBz8517wQ5
         aYoQli4hRaRfKO+5PoiBe2O4lRe/e3s6fjvmjuBni3SoaZtBkYsxeig2IFaWq/UrK+jU
         L4sKj/sVg66gbieVsVatNSfVakVpJuAwG1GkoTa0NF/LpJ6xwADmo7HSDKUkn369BWHH
         52Hx6XQ+2p5vs+udAKUOVJ1f5PQ+49HncKe6dg8zWfN4Ln1+z8SfRwjA8cl/DE7+j8+m
         Fqng==
X-Forwarded-Encrypted: i=1; AJvYcCUwgu7xbZ/jSv58zn+NPp4oHLXkt/uWZ2/pwtzYdFyR9vd07vTYSKBe39oZrj3L3MwJ/YQ1VV4tcGYw7O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+2aq/l41DhZMi4NPgI6NYXwX3GTleKckG2ROFIc2AN19Y5sU
	Fao5+jcuODSqWh5hiZkilBpM3Or2eo3aLo0peKQ7CMctDOtmJBsFBBsq3h6bUy4qVvHN95dnhUJ
	+5n84sw+dF4Ea7fst24ZIrs5DKS4pBunuXPg=
X-Google-Smtp-Source: AGHT+IGRxWn7AtTgeZpuWRz8V5rd6W5D28c5D4Sbrcq9HPFNDqqf74JfyLHjNc0/1W2sZ5vG7LWV4Sedoj4/HpTIDrY=
X-Received: by 2002:a05:6512:2807:b0:533:4b38:3983 with SMTP id
 2adb3069b0e04-53678fba44cmr295554e87.20.1726086247114; Wed, 11 Sep 2024
 13:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-8-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-8-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:23:55 -0700
Message-ID: <CANDhNCpaBb2TJb8K0frcyqDPD9qDjuBdUkHkK906-H5f+uOm+A@mail.gmail.com>
Subject: Re: [PATCH 08/21] ntp: Move tick_length* into ntp_data
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

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

