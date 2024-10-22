Return-Path: <linux-kernel+bounces-376363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350469AB05B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0212B21ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C7819E82A;
	Tue, 22 Oct 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXrtnkoE"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CF19D88F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605826; cv=none; b=Om4GZLf0CCOuC86/LtH2SoGlTxUlVPlxz/ycr9TJOFHAM6vmXkGodMyeEKj0nwH7gFdo63VLBqtUgZn4Jbk7LlDYpzaQQFi4PLyX8aEtsOlph0J+ek31NOY9jTloe4727QUnUzWBU+42O5a2CvIYa/YI4WDU63oDjJb5xwS9LmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605826; c=relaxed/simple;
	bh=dKHo3OEYzWQbM8cSQiQVwvynFKVzn0oS3lzkqykCe/o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrE3QLxG46LXHFT2IgCX66HIAjiXNCuAQazlBVCCsrjkD740kFrQytQniq0Ogb/+I1fguexBJEvnrP96qbwTZSsTbWjMyQHFRK93Fj8YDC+ms4Tu4QS+z66S65flhej5NRpVBBo15FEgAW1nsIawvQv5EkBwSDmqTUBtw9biXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXrtnkoE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f58c68c5so8641679e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729605822; x=1730210622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5AiP4cJPRBzyRIieHpa29joHmI8xJuHVk8wEZsEHAks=;
        b=QXrtnkoErI9OAkBC9giDA/HjvA+sGyLYHyNVIawAEE9NGjBNpt8N/+c0pgvD4Nm0tQ
         yJ/o3wHLup+IWz9XzYeAh3sdZKM2y/nGASk21mnYmAnV2qbpSXO81x80v5tUZIq7LrrY
         XL+3Q8ldJ3kwcu0MRV7RRrrswbEGD+zaSUAXmsGwHqJVmPlfkqh6RwhvQ6KbDf9P3Hjs
         2zPCNfHTwWcQgiMy2wrAmO4VkRmOTzY5Nz+FL5rISpOv6hCazyqKB2xOLcxu2MQjQd9r
         1mz2Y82ywbII0UdbQsM4BtWRcHXqXfE7Hvw/bxtxUf7OoNj79nx72fCEPxSKHS01bJL3
         mgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729605822; x=1730210622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AiP4cJPRBzyRIieHpa29joHmI8xJuHVk8wEZsEHAks=;
        b=AFAkYKVytxXVEY0kdyZsp04lfcUotFzGpDHcgVX01d6sYtXtotNE7/ooLL1ErxLXRD
         H2/lTCDhPXj2qbEG7bgf2yXhmYgXb+lAaDpWWrE3Y5Fy1G4Dowb6if2i94LzBjxx26XA
         uqydARVKE8o1tGqH3VEgrBZJV4L/4K2I6ezoNG7QgT8pNgcnlxq6FKBm78lvxDZiEpv3
         TV9sTiEv9dtAkovMGHtjEB10lCeeYxKbd5s6zC1NPZEwjJ1BvVwICQYzTFIoNXi4QE6Z
         WEwa8DaqtWqrDfrtS5eeK54pQUta9Ov25LdltamHcQLA+v9FMUf77jSc939PIsC9AxKX
         mWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFiFsMBpzv+JkTHzVdY+WGtfpl7Klt2nRQBR/9pPVzI+F8CVkbH7Ce2LT42COpCUN6UZJ/KLr0usf6ac4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2N/mTkoPB6o7lfZHoUAqrarizrEnPM9Bh6QfxPV9egzXZppay
	ahe/5CSMsADkdLnvmiqRbiSYeI5gHh0QKbKYgPUlHmzquWeHZt0j
X-Google-Smtp-Source: AGHT+IGSgR5/mMdGZ/m84gHdnpbw50Ph5QyBXEYMUq0paVCiS1qpZo7/45ILcvz6LCpK8WlUxE69mQ==
X-Received: by 2002:a05:6512:a93:b0:52c:e17c:cd7b with SMTP id 2adb3069b0e04-53a15444f50mr13846305e87.22.1729605822004;
        Tue, 22 Oct 2024 07:03:42 -0700 (PDT)
Received: from krava ([83.148.32.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d638fsm346611866b.18.2024.10.22.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:03:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 22 Oct 2024 16:03:40 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: andrii@kernel.org, yhs@fb.com, linux-kernel@vger.kernel.org,
	daniel@iogearbox.net, sean@mess.org
Subject: Re: perf_event_detach_bpf_prog() broken?
Message-ID: <ZxewvPQX7bq40PK3@krava>
References: <20241022111638.GC16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111638.GC16066@noisy.programming.kicks-ass.net>

On Tue, Oct 22, 2024 at 01:16:38PM +0200, Peter Zijlstra wrote:
> Hi guys,
> 
> Per commit 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return
> -ENOENT if exclude_prog not found") perf_event_detach_bpf_prog() can now
> return without doing bpf_prog_put() and leaving event->prog set.
> 
> This is very 'unexpected' behaviour.
> 
> I'm not sure what's sane from the BPF side of things here, but leaving
> event->prog set is really rather unexpected.
> 
> Help?

IIUC the ENOENT should never happen in perf event context, so not
sure why we have that check.. also does not seem to be used from
lirc code, Sean?

perf_event_detach_bpf_prog is called when the event is being freed
so I think we should always put and clear the event->prog

jirka

