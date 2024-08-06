Return-Path: <linux-kernel+bounces-275884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48E948B79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EED1F21D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027C91BD01D;
	Tue,  6 Aug 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HCvnlc8a"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374115F409
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933640; cv=none; b=jaWvVvCpVX95f3sZrZttJZU65rjBOM3CDOcNQCjUxFp7l7lC+zPw4CDnD65AgzPirOEviOJAkRcW2AN572q6L0izGNmyhlOC5nD2SxZ1JOihdCog4x0ErtE7VF+/wP3iuaua5wiSlcNnzHqgLd8XyNGgbh1LtIrZRuUKCyJKvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933640; c=relaxed/simple;
	bh=MIDzH97CZBL+oGp0On6cah7YVfvqS9kxZSnn4YjypCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id2FU2NTDb066I+N/qUJ61nKwrDrFe9w2QAvpiuZ7557lT437uACQEo9OIz/95jV8O1ZTuvYwcBR3VJOziP3mvSL6vUKvp9SNCxCyDkGDK9dLdyzKXFSXLSoQY4RPSkYP6idYo2wIAiogF33BfPH7t4yTQPstk5HKea7gjrb7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HCvnlc8a; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so52060366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722933635; x=1723538435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oo98tS0UbkLm1FqZpRtoVnNJlJpnap4AtGmvU23cjaQ=;
        b=HCvnlc8akf1oa910DT3Vd6/5dG52eKPEbIvAcNMQqFfqyXDf+hDKchdb2SrpNZrU8J
         gGD5OMslhIhjS+s+uU1zsbtOWPLcIXUmGd4uMQ3ULFsM9Po1HVXnORX43DW9LZMg20IB
         fd+N7GJ83XBYrn8rZ0DPSbRBZassi2wT22UQzxz4zbxgNgT4Tne5yWGwLwHXDgkmghUI
         eqpa7M4Nj0oRCsiqUDptEaunn+cYeM88emPFMCH4DHul/jfV4xS7QLFmuOGnAQSXQIv3
         ODSFaXgdCwz0mbMxj9P76xcuJRQ+p8jHMiMvg+CvMpjI7z78F5E3URrnni2XW1ooStzF
         TnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722933635; x=1723538435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo98tS0UbkLm1FqZpRtoVnNJlJpnap4AtGmvU23cjaQ=;
        b=m5neo0k0+7eWeXmaWQTt2hJi8dHQmIy7IGQ5t8e+D1QbvbhPiz8YBkfqOfdt7t/bgh
         fgJoAOXF1/lUm6uph+mvZkllH+POJpG73FAEyPop4BilEzfE4ErBY8kcfrtClugvBzRJ
         IOS6/5eM8CmBm1DbfEleel77V3XRuQy4CvlaTF7DEw4phKMrM1ey9RKpFxqRVtN4+tLo
         KCOnww8luJPBYbsEuAnD27XFXP49/vDYqEG3kOouM2JpnEhaY5J4o0oNjH01i29cYO36
         Givj6++4GVjILLtHFDVfyw1wRIuEkadS79xumvWE3yOBUkmgrE1QH3W7s8fREchdGMWr
         U4TA==
X-Forwarded-Encrypted: i=1; AJvYcCXNOwS4LZxjRwqXGRX464PfA1+ZT5YKE30/t+0g5qrjKH3SMJ4yvvNd0u2hmGxcq8f4sei7yV6RIWC6Q7IxqyujS+Of8z3QVGV9Ln8A
X-Gm-Message-State: AOJu0YzdHG7JCG5BcRQHoOpOwQoRLkzr/ruwH4nIe9D3AdRPphFpOLXn
	5OloRMHGrMdVD4j8GXUdIenUTuBDqfHFXhzkZKFlnlH4WrfZWzKDVgQtqOtZu05F3Bh2/wy1cZy
	e
X-Google-Smtp-Source: AGHT+IFO6kws/3PXc6NtHApV/OldK3zmDJd25cPz8UXEMr/KLbEiGYGPyfJg+qv4pKMGq6RJKHj6gw==
X-Received: by 2002:a17:907:c302:b0:a80:5b8c:c586 with SMTP id a640c23a62f3a-a805b8cc5e7mr103519866b.0.1722933635350;
        Tue, 06 Aug 2024 01:40:35 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d426a3sm530219366b.137.2024.08.06.01.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:40:35 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:40:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 27/35] printk: Avoid console_lock dance if no
 legacy or boot consoles
Message-ID: <ZrHhgcD7DafApeOG@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-28-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-28-john.ogness@linutronix.de>

On Sun 2024-08-04 02:57:30, John Ogness wrote:
> Currently the console lock is used to attempt legacy-type
> printing even if there are no legacy or boot consoles registered.
> If no such consoles are registered, the console lock does not
> need to be taken.
> 
> Add tracking of legacy console registration and use it with
> boot console tracking to avoid unnecessary code paths, i.e.
> do not use the console lock if there are no boot consoles
> and no legacy consoles.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

