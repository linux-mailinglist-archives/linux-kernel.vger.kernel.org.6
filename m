Return-Path: <linux-kernel+bounces-211946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59A90593E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAAD1F225D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46D181D00;
	Wed, 12 Jun 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d+l1Ih95"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACA17B437
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211457; cv=none; b=lIV5j7rkyhGYXeF3c8XGOrHoBakQI0XkqB9XEAbgCEaPY+gunTFeh9RNo842hqFf2za4xZqX8KI4QYYFRvX7VAWuo2UTwatGfsZSE0pkUcULbeYSirVADEgXDzX7JsTsTt3NxW5bVRFkjB/WVEkLXdARbRNosWGHUdGbJE4B6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211457; c=relaxed/simple;
	bh=vebMEaW02jolhLdtvQPmHMC1OEEbWYTVGy+Bor5wYMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DL9hFKU6RG5pmCFrccmny0V16dcBmUWU7fVlYIUG4PgQ6BN3B1f6wRZ5XKcrcCXbaBVZ5Jj5TPLA3MEogAZyIonPnm9VrUs5H3hvRbsEZbcAbR3M1yuX5gDUqugp9AgfXBSUxTd9lQGj/Nt1XJa+Frsm3nII6iCZ1K3w8bnlJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d+l1Ih95; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25075f3f472so485fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211454; x=1718816254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAftVLKn20HbmalpH3Tni7KQXwsU3yAXAUhGqIphnu0=;
        b=d+l1Ih95QeAlRyz0HNZpXALgmOEuWDHQFwfysCuMSY3ZA40F08jSQrUmTx2gl8Mbi+
         qAETXqgkSFv7duiRBXhNNElzK1VVoCXfv2y/XbbyBeN+a1ELF6YOq1oisGmpkBIKFg0C
         lJs+G9IaBI2Jo3r42Kh5/Q+/2ekT/FTHoR3aMcSN7Ct9U9td6I34ihp3783vBaahWA1a
         xRNBvWtFrMdMiIQXMR1HdrW+t68KdtxtXG7LqNhNB7eEyyv2SnHKIax2Eegwp140t4Z3
         cJqKx4WWpXv2EYYO9vP5miFNt2qW9C3Ff04UoqH73lraY9p+yp4q3CJdltjhgBC0WfKW
         px5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211454; x=1718816254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAftVLKn20HbmalpH3Tni7KQXwsU3yAXAUhGqIphnu0=;
        b=biys723R+9IJ4tDEf3OAaSRycdKj41PeGPk6+98OuaS9DAhDmdH0nrfqES//ct6N/4
         p7TYiXg9vxhoBgEuVCCPCwkA3RVTVYN9UE07iWAoNpYmsJhFeNqc+azaVZ5sNGxVIrEN
         fJtbdmdLDBsDfnT6Jst4D7P0FVHT5dtlX7Vg1yS92JyTNlmUq3GA/6hs9FEtCZS23yCz
         JF8epS/EEe7BIQnc5H3QL3dUY3enqKRx/g0dfxYXuKrh3ht0DII5qc+JZoD0Ae5PNdFd
         iSxvKaPqelOBUN5EPGc5PD18t77+n79zioHkZQZheVD7XiHIakaVUXr0bLttEVhL0tKa
         9KUw==
X-Gm-Message-State: AOJu0YyxDTtoroSnxVagHk+gKtxMLNeFOReTRYktrnEXoL8iEy1hmOeq
	Rvhd7JM8oYtCPSfjPqGnTbR3vI4ShpbaS4f/4eEkrjtuLkhwJk5gumsqavzUT/k=
X-Google-Smtp-Source: AGHT+IE5gURtOYtjCbJQWtUubvSvxNRA1uBWwaFjKaz5/Y4ebMHZrD+Oj4sfPGkerxg+PybPLlQnIg==
X-Received: by 2002:a05:6870:818f:b0:254:affe:5a08 with SMTP id 586e51a60fabf-25514c7026emr2515800fac.2.1718211454633;
        Wed, 12 Jun 2024 09:57:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-254d96e5e7fsm1377401fac.26.2024.06.12.09.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:57:34 -0700 (PDT)
Message-ID: <ec203c0e-13a9-4163-94dd-a8a8d6d2c070@kernel.dk>
Date: Wed, 12 Jun 2024 10:57:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with
 TIF_SIGPENDING
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Rachel Menge <rachelmenge@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Wei Fu <fuweid89@gmail.com>, apais@linux.microsoft.com,
 Sudhanva Huruli <Sudhanva.Huruli@microsoft.com>,
 Christian Brauner <brauner@kernel.org>,
 Mike Christie <michael.christie@oracle.com>,
 Joel Granados <j.granados@samsung.com>, Mateusz Guzik <mjguzik@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
 <20240608120616.GB7947@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240608120616.GB7947@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/24 6:06 AM, Oleg Nesterov wrote:
> kernel_wait4() doesn't sleep and returns -EINTR if there is no
> eligible child and signal_pending() is true.
> 
> That is why zap_pid_ns_processes() clears TIF_SIGPENDING but this is not
> enough, it should also clear TIF_NOTIFY_SIGNAL to make signal_pending()
> return false and avoid a busy-wait loop.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


