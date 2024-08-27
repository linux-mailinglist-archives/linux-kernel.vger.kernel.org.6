Return-Path: <linux-kernel+bounces-303604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC53961083
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C961F23736
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D631C57AB;
	Tue, 27 Aug 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GGTp65Jn"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268C12E4D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771384; cv=none; b=Xe9S3ynUI17FHU7ZyizzhJvZTnKHOgEtQJf2WRATh8FxTtklWbXHC+fqPXPdHSJhwuqHGYH4nulVeW4lZ3WsdsIKi2s3R+pF9+3nhpVLpzF5WWC/rmqoPrY9nicsb/HTvykL2DGJnfv2qJrgBOv7Ry/XMLR5R0qIZSePuICdKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771384; c=relaxed/simple;
	bh=8QQYFgByboZVI9uam5soQpUvoDQc8v8XTD4OZr6CKNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvgi6tlQcHHcZbpRW4hT3fFfi3JmTneYhCW6evYCq+hUUdangCfNNqKde6A1G3Z45HXFQq+2FTkEL5sxDf8GWfZmdXEDslThSehNwXTlwx7vM8KbkpMZlP1E4Nn/7cGtlvse0SHevQ2MIFzpnV1EotB5csTW6rlTKNOW6kD3EQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GGTp65Jn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86910caf9cso914497766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724771380; x=1725376180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASBDdEcwKzU9nr4gU62n0oyeSmxh9pUb9w3VtBSsSeY=;
        b=GGTp65JnftSViqB4tjk19KqpdX1eh+nMiQ/rFRB8qNLD0qgC1uwPG1BK9qifrDanaJ
         oDIt0fyWhtb4JwrjCoiXqeQCTeB/xeBtNPtUTOkLyfmVMFIuzQG7dQARwR69e3aZUqve
         mlZdwoil4Qf6t0L8oc3v2nAJcXOemkgYlKtBVMi6qTsb79CAiYFtAg/Xswnfosf/4BzX
         BtVC5TdvO1fL3KoQp1pWVfPl8dLI189gtmvMaih/Dj+G+fExjLArzpHij2Xs5VAK5GY5
         sqtV/lAyuM1/w4psnDG/PW6DXQV4Ra90fsRKRQzyRP7mjTI/awGpn4ZOY+5ueENMyVvu
         QNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771380; x=1725376180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASBDdEcwKzU9nr4gU62n0oyeSmxh9pUb9w3VtBSsSeY=;
        b=wbcy3lD/qX4uAD6JRf0uQZVlt7r1SOUL5See46AcfgBdsC6NHdbuJlWZXCDM6yI2r1
         WTY3pEljSjSOBzaWAyLm7AS/Z7Nb2MtP4IulDVPSh26DEzEctjIAptkQDIEhya9SgJmQ
         bo7OyDs8oRNKiJ4/DJtnMd/8gm6e2SNWGn6dAR9RryziTZ/fvyif9cpGX3KmZaa+1qiS
         jb35ZGr0EchrplP4zVw1n5s1rraQDBUYbfDybseMaWPvigqqlslOiy6XVVMSNFJ4gGsB
         ruWJ8D9TawYIdxWHYJuT0wOB1a6tCO7uCuXeRC6zQqcgFHTQYkgvyXBy8HTMPwLO08O0
         NE9w==
X-Forwarded-Encrypted: i=1; AJvYcCVC21huU9DEw6msxLFCXnp8oZAxasqpJBT8pUcl971DW8H+95MGA7jao03KZ9wfTw0YxNcqAdeNkCT6Ji0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HkFq4x3pi9CrMF+mlQzM/kSAsiB3teYxzLe7OVyYTQvQZ3AQ
	M27MutJZo/vwWhzcS5QmPUUsHTF5d9sJfq3mFHaigVvBIuFLuxCjLv9+sWqVLZU=
X-Google-Smtp-Source: AGHT+IHCHMw5EQ4dCbgknMFgfAT0JKWSWlCq5BFMLg31mYsi30KIgWQ7BCxlZRlX2GEkHOP9h5syNQ==
X-Received: by 2002:a17:907:7ea9:b0:a77:ca3b:996c with SMTP id a640c23a62f3a-a86e29a06ffmr349319466b.16.1724771380317;
        Tue, 27 Aug 2024 08:09:40 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e6c3314csm114816266b.178.2024.08.27.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:09:40 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:09:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 08/17] printk: nbcon: Use thread callback if in
 task context for legacy
Message-ID: <Zs3sMrQCuLoPaO-z@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827044333.88596-9-john.ogness@linutronix.de>

On Tue 2024-08-27 06:49:24, John Ogness wrote:
> When printing via console_lock, the write_atomic() callback is
> used for nbcon consoles. However, if it is known that the
> current context is a task context, the write_thread() callback
> can be used instead.
> 
> Using write_thread() instead of write_atomic() helps to reduce
> large disabled preemption regions when the device_lock does not
> disable preemption.
> 
> This is mainly a preparatory change to allow avoiding
> write_atomic() completely during normal operation if boot
> consoles are registered.
> 
> As a side-effect, it also allows consolidating the printing
> code for legacy printing and the kthread printer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

