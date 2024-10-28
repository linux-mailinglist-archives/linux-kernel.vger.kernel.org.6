Return-Path: <linux-kernel+bounces-385332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D679B35B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40809B21F73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D81DE886;
	Mon, 28 Oct 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1E8nCHaz"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10415C13A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131545; cv=none; b=ZOdq6pNASkhbcnslus8CGL1nalTakSfqQnseINJSs90F/zMM8cpAN1RWRpWfXFjlNnSeUrVUNfuuy04xj+MoSTm9/dIQTX8/u5oElJ2RL6O7U+JgIlmMt+Ah55YKV/Wg2JLMbQ+OHLOoTFEfZV5yudBQPmMx5csd4PE6G9xOBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131545; c=relaxed/simple;
	bh=l3Cp9BeMNFNwz6C7czruHn0SabbRUc5K/fwbW1PyUQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rYkoWkiSk1WpLnpwVgEjPGPwKRSd3YVIKrhnf8TtvVhLmoYIcLUBJFb6HECaHUC2L+d4plXheNS9l2jOt3jo7HWZwGyTjuCb9kg9xTYRFW9Ed+4lIY3W5DztzXfvGENWZw9KNxqVmyA5FCCDaZVDvh1YrDRF8sAYq8nCBcpo5qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1E8nCHaz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso4056098a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730131543; x=1730736343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3ie5ifufASI9G1WuRdLsyt/LowS1PCrH+CXnaSQRWk=;
        b=1E8nCHaz7pMDvveBg1/ZAzCfsimwiYezJq8l94lXGZbpJ/VZv0wkfMldufjkEvySj0
         nbUu+chHpWfK/fdTp5J/UsGebtJBo1ryf9tQM0IFLogyTpIZCkyJ5yXvt+QBHcu1auOo
         /bpvdPhzhxfpBYFzfbyA/GOoBzpVgx2fsdwWsj5ArQHSdZS/2bZdqJ8VcgxgAJmKowro
         IgQIu/Sh6r8oMOcfNu92cEvKmxYVt9aZpZ3E2mLLBiZkOJLA2N5kZOAcJqfvsvH54cW9
         lVyUdI1tCMsE61nl7k5ANN3xqUqGEM63ypJM6kzQjlRg4iIPv7DFcMgKr6ZCYHoNRH99
         F4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131543; x=1730736343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3ie5ifufASI9G1WuRdLsyt/LowS1PCrH+CXnaSQRWk=;
        b=LU/AgbUy/ccw9uNNlM8dL5sxHv4xCjY/FSl3X6SngAwaU4DgrqqVHRrb579Doeb64c
         qM9kutfxUJvVZitAd/ThIIsOJAQ3pdAoa5lEDocDKOlGuWSfnf490Tjgv3DLCRMtyOl6
         JyVtQBnTNToj2FvjOUO/PVcJ0GFLvUSnMbGLE575+oXddY+s5nPbVbcAjFYsX0LQ6zb+
         rZs8OF5EdHT/LTPJ/5ZQk/mVzz/FIqsyc+LCaf+3JfA+A41Mfoayt/oaPZCmr/ubvNPF
         AQSdWeDFTthCEiMFfdRYv1KwOHqj3zJTT3u4zkpNkzlDRH8L0dCSRIro/CENLek7Y1sv
         CXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1PNfyoC5cmHj4kAYxyALTaDJgqdpnwCa6FFpByj7xbFnvCuCMIqosN6cP/n6hCSp67Vh1U32AxdMTDUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYO3haYCXzY3tk1TKltUCFfakqM4iTPKDNa2oXCcDlGJ1yQXg
	nitzJXempTnyOTXLMQTM2E9ablhg5F8YEzaz+SSXJrR82KuDvNua70aBldVRMFwOQ9uNMyWVFmV
	D/g==
X-Google-Smtp-Source: AGHT+IEkBL9DoH8uTQuOjkre99PEFXZckOFmK9CscV/GJCoHB/bdQSJL+dlAtt1G6F8MmFhv2zGn+OlwJG4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:155a:0:b0:7ea:6ca8:bec5 with SMTP id
 41be03b00d2f7-7edd7c5054emr16022a12.7.1730131542804; Mon, 28 Oct 2024
 09:05:42 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:05:41 -0700
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729864615.git.namcao@linutronix.de>
Message-ID: <Zx-2VV9rRnHOgtvG@google.com>
Subject: Re: [PATCH 00/21] hrtimers: Switch to new hrtimer interface functions (1/5)
From: Sean Christopherson <seanjc@google.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	intel-gfx@lists.freedesktop.org, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Kalle Valo <kvalo@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 28, 2024, Nam Cao wrote:
> This is the first part of a 5-part series (split for convenience). All 5
> parts are:
> 
> Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutronix.de
> Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutronix.de
> Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutronix.de
> Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutronix.de
> Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutronix.de

How do y'all anticipate landing these patches?  Is the plan/desire to get acks
from subsystems?  Land the new helpers and then let subsystems grab their relevant
patches?  Option C?

