Return-Path: <linux-kernel+bounces-275876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC6948B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078CE1F24DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390BE166F04;
	Tue,  6 Aug 2024 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DHuGHc/4"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D513C81C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933108; cv=none; b=bIWXUK/6t4c4uRghjZiskOzoMgmXCWSpaBbS5Wc+9CuyoN54a5ZwoVXJR/+T+/iTs5MVpvGOvYcfTfjH2mMOulUYSs2OUMKwFU5bRzo3Xmx25gsQxtq+6HdMXoNnJowrV35F2TXZM+YEyVXc6Qp6FuyNR9Ch+YVgmwVcp5ay9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933108; c=relaxed/simple;
	bh=ADbfHF5SLbTZu/49d6BF7A+/zS8bdYiC5YkgHP6Pc2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSifAuhyXnP/fSFnS9sHkrPaVrDEmmqqMr1EUynv3TbCKpJPsq5eDdFGWudDdEOf9F8D0lyN/ZCs7S6dhTDfGbHkClGrQbVxaZw5SZswky3ISdJuUAw1OQkOpne52bI5qc1aZIooU7wu50B8dRb5StlIcwgC2Cwjgq13jvoSc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DHuGHc/4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so38126166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722933104; x=1723537904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWHbTsmzUvq8K6J2AuS20Jn+/KY9S4gOMGe/c7k747k=;
        b=DHuGHc/4JVn4wsU7z12WIpr0u5BMTwKTre7SOvnX0Va5RD/kqcpi6Zm22z40D7eTHU
         yD0ZRlxfJtEhUXrIgD3TqXj1c75L7BkslwNHV+iTPBW+LboEvZpOtjx5tcNFutjL0Hi+
         wp28W8ipZfotG5qXdnaKnO6mVB9+Tm4nwrQQZWnPZSeLslvMoxm9wnJJoFmqBCJhFJiD
         2JScrv7t2ibnP5WTQLGBfqQUqE0a19C3agV+I+H70dKxCOdHuUUejp9Sn3QOSOragmvf
         BKjjU90x7Js4KASBwgu4udsjzDfLRYa6hxYJfoG9sYokC1s8N7C8Vj4eVXEOzDq0T/gx
         Pzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722933104; x=1723537904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWHbTsmzUvq8K6J2AuS20Jn+/KY9S4gOMGe/c7k747k=;
        b=NE5mIlTMhpSBCKQi4NU6Ng/ygFH4i0H5YupOKEEb62daje/RwGFkuLgvE7UKy52KFN
         Bh6nE7xWla2A2osoRKLB3JToWspmn6n0aE/bwTCl3uTmnxTCRfPv+9yktjkQ8ozd25YH
         Hvt3WHyLbskJReNEFlp6MrYatIncRVwQe2GfPQa0gEX/Q5EsG2sn9IiZSUEDHx9lrsa3
         BVeGLl/2NKSqW44K6s1Q0f9l50F5kZqZroxXJM2/T9VYpf/FC96L/Yf1RUqwUFHsaOiK
         0mqU2p2B6/mk/UzcQfmhFUVQDHk8CI8sqW84jh1Yo5uuuuBxkNMAY+toowOu0EjxF51u
         MFgg==
X-Forwarded-Encrypted: i=1; AJvYcCW69iMYarkzvtC4UkBxKoKG+5+1uCIHIvft61M69XAOZxHSY+7ldC9jn/axuCu1sf1vntHaHXMFTZ5ykDBOUsc3iujSKTK3uOoVkQ3b
X-Gm-Message-State: AOJu0YzMi88G7XoIrmxE577NUk+Qixzr0ENjtFlp62GXRPQ330MqU3B2
	EUmupsHHFQfAEZIJ32nPtMP/PZN7qAzLvwCB7fhPMhBASIY1/7klOhWE6MwYj4Q=
X-Google-Smtp-Source: AGHT+IHo3o8Bs4sjIWPgw4wofCEeRPgu2vrUK59TpC5x3FjuPW6SXthNSVh8HY9dJqYUHRoExjhP4g==
X-Received: by 2002:a17:906:6a09:b0:a7a:bae8:f2a1 with SMTP id a640c23a62f3a-a7dc50a2f0fmr1030184666b.42.1722933103820;
        Tue, 06 Aug 2024 01:31:43 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc9db6sm520610666b.8.2024.08.06.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:31:43 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:31:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 25/35] printk: Flush nbcon consoles first on
 panic
Message-ID: <ZrHfVKnw_n1mOXmZ@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-26-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-26-john.ogness@linutronix.de>

On Sun 2024-08-04 02:57:28, John Ogness wrote:
> In console_flush_on_panic(), flush the nbcon consoles before
> flushing legacy consoles. The legacy write() callbacks are not
> fully safe when oops_in_progress is set.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

