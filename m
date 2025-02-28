Return-Path: <linux-kernel+bounces-539571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B42A4A5E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CD77AA5EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50A1DE2C4;
	Fri, 28 Feb 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzveOQAr"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ACC1DED78
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781639; cv=none; b=t3CU8hDRrjeTWgvjWuwvFuwzs43nLL71NMKq/22ZIq0ruZ2MVbuoJ7RB7LC8YHaUFR7Ijsz6JoCQEPQKEw2NWBMoBvN+GqGUqA3h6TQVhmtViN1FmsxcdPFblyhfJaNam0tP8/iJSyKK9dRpH44B90eply0iTfkUsUMP+oI40Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781639; c=relaxed/simple;
	bh=1GVvDDBZou6faFVHwBQsFrVBIFFXe6j/fIeG+Ip72go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NHiQ5H0SudO/+RgfaoYKmDySsM+HDgIl9Ps13mlRKpVOYBpkH9SYIcCaZFzu8+Y7ILpEb1Xtb/UDaNoVd+pwhwUuUrCUj07/ZLs4/pk8G9x6UoB+B5b2Z6DEVSPZ8kRtcoOfqoDygXvQyU9WaV4NOS1dr9KtEDTnVO5IE1psOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--colinmitchell.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zzveOQAr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--colinmitchell.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so8812012a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781637; x=1741386437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1GVvDDBZou6faFVHwBQsFrVBIFFXe6j/fIeG+Ip72go=;
        b=zzveOQAr0QuReJxobRAitPc5OoX0Qpt3f64jCRjoMgj9uBvoVfZ6KIDst2N84huR4L
         lEdDPUwY9yWnjc7GSgPY74eJah1u5BPJdrxHZkc/vP/CMm0XEvPQRlKpYPIQ0Ls0nsDc
         Sxe6sWWYrOwowTlLBniTs9RB4rXG2XwrCtQ+y4V1MUiKeSRHotjuxgZugo6cv7VzqtUj
         dhcOSWM7ANR/NN4WB1QrLaFx7dCQQaVa3Ei8J5nuUnwbmqe44bPx/vd8qH5WARQpBe83
         3D45VzWhflffSb8djMpghrcILu6h5on8LmeOBpMdCQgAgepE9w2XsK0t9S5Kegs4v6WT
         Iiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781637; x=1741386437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GVvDDBZou6faFVHwBQsFrVBIFFXe6j/fIeG+Ip72go=;
        b=qkTPibWK02gREuenSJ9xccWH4ozP1oXuAbD9KVl1O2KdJlZWR3hZvbD7xRH1g3OG6w
         rZ9r0+knd3yNaiDKBUqoonvYb1gXBx1DES/vbR12Tnzuo5t8Z9GHPRDR3eYo4Foox1B0
         ewRe1VYn/zDf4lTs2IiXkN3DXctn92HZ3vaRdtQy2FXogUa7Wvznqm31UjGC6MkVJE8C
         zrRaKAEEf9f9i6/ktnI67EYhhRxlDH6lZnGKo2bv/25qUSlANe8L+uhzMA0b5ggrWH7A
         KZtIJPKD6MqcyhvVnrtbFDGa4q/8BNrOYkfDQdx3AkTfDzZ59o7/oKq/JW87pQs+rlG9
         RryA==
X-Forwarded-Encrypted: i=1; AJvYcCVfyeqZDeg+8DnKSqK9Gj/KQrQHsMg6Skkmbv3HZr15qN0BSY+1YEROllhyv6zSnqiYlDYLIXMFefYJ0D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaN34Fp2oMt1tHMzMJJcA/no/D/Cnih6CiWWdDyvzCpuEJtcPI
	6hk1w2HlQN/GslcuUBkBtr9Cer9daO+VPVzmRv95ceEVdl4uwWVmrL6hkmlBbfDIdFSnm1PnkpB
	0o91SynL7JlJjJZ/ndijxQrbuG6LG4Q==
X-Google-Smtp-Source: AGHT+IF+UNCeXcB/Q/5kDyMmk7LTqlDmlGeJJuyfmr3GyDcLApiPVRnFN6s/m2L3tZpATeQNoXIBT2+jispVMjDbEdyt
X-Received: from pjbpv14.prod.google.com ([2002:a17:90b:3c8e:b0:2f2:e97a:e77f])
 (user=colinmitchell job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2688:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-2febab40303mr9152728a91.10.1740781637746;
 Fri, 28 Feb 2025 14:27:17 -0800 (PST)
Date: Fri, 28 Feb 2025 14:27:15 -0800
In-Reply-To: <b0cf3395-ed21-4f48-ab49-81c67f6a032a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b0cf3395-ed21-4f48-ab49-81c67f6a032a@intel.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228222715.3306015-1-colinmitchell@google.com>
Subject: Re: [PATCH 0/6] x86/microcode: Support for Intel Staging Feature
From: Colin Mitchell <colinmitchell@google.com>
To: chang.seok.bae@intel.com
Cc: bp@alien8.de, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

As a potential user, I'd advocate for an option to disable legacy
loading if staging is supported.

The difference in quiesce time between staging and legacy loading
can be significant. Since late loading is more of an explicit active
action, I would believe allowing the initiating process freedom of a retry
loop or handling any errors from staging makes sense.

Presumably load_late_locked could return an error on failure
to stage leading to an appropriate print.

