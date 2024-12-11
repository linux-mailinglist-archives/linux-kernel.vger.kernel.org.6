Return-Path: <linux-kernel+bounces-441447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED30C9ECE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2972E188364B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1CD13B5AE;
	Wed, 11 Dec 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bm2B4NqQ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292A246322
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927078; cv=none; b=myo7JK6I9Zi1Q2sRkJAj5g6e9V7te53vZ3HR+aKWUr0XOr1OK6ItGduGKPwKz2GpJG1m6uFuqbn0ITWnt+cc8bXKCgKFI/kkwz1Z2XaoACqKBbb0i2wqdfxwkzdGVbj1Thl4TQUD1KZCOOnXFqXYIgHYVceKNPc8ZIGzdZEjB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927078; c=relaxed/simple;
	bh=uzP4mXKgzQ8050Z+jX1ltzRvcoKhnE2DNPViE0ZQMOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjwDLtZCfbDR9WHKEy7wVpbPlpXO5747l5oAUL2o8cujFtyFvN5DWuYVhmcYqbEkfJFpCfS3XY/rMr/FZWAgWS6xaDC5GDz/HcqAlkMelko83Zu/RKO7YYP/62SoJnOOWU0jfj39VDkCNK/JS+0G7HuI1LyYMKuXQ3WIkWHy07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bm2B4NqQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a044dce2so75787785e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733927074; x=1734531874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUik0fZMAd+bqv0OcocEi5jmwaoyxM+p5pKd8cBHnJg=;
        b=Bm2B4NqQIuPjLCX388jmJ6WQWJKwGYfsIhTB3AkUBJKW+XqLs5/ReOwgRw/VjzRQIa
         +eiBFiNTWTEQb8tv+q5MdbrDD3DRjSe09UvcEhFDO7YeDPkdezW5dz2b+ZjcXBk9unBe
         U6yihMiw5ZFRnxMO/H+Bv1TSqyY0QerYijEghAUXs7MK4APU4UPERA/wbfOI6wNeLIcO
         zArBQGAsxeECaXKos5qel4B/8Q1LpKEv6z6I+7aEMgjsFlUF2h/47Nl3YRx9rDm9eWAU
         7NC9mU0pZHToajE2mEAVaAd0FvyIkYxHaMQ07qwOtg3hKVrDiSDLNZmo3PC3UKH5eYCm
         CVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733927074; x=1734531874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUik0fZMAd+bqv0OcocEi5jmwaoyxM+p5pKd8cBHnJg=;
        b=T7S8zIpwqdj3HzGmq87MDc0VFkQyupP7Smb2vpL4WgxsYvZKNUkmdb8Ese64hZKCNd
         juoT94jesqSAe+BtHGbestnCKPDl4osR1HlZ4MDoVG72yLsuMlMpM4emqCsxNnPq+SQs
         XDKmgXbDxE17ofwfrNxZobiIFzJrkp5c71d67dQ8XswWRFbScWJCRRCgCsM+f1vHqQ58
         GUFKt8Q/AeL2gNdfTLbl4AEUMlkTBPXmCnob3ftSZVao1J+uoIOvwY1nnWic7lbMW89T
         FCIA17XXA4hIOI3C8vn+r7vnpz1A5tdQityoGMwnVgiKWUreCcsxox2wcRKQW0OWLKVc
         MUVA==
X-Forwarded-Encrypted: i=1; AJvYcCX2rR5Gy0SSYjf5/qpmgNtm63TffpmdYE08je0bGkeajT1KOCzuAdEMquReb+MT/sOmaDneiC0WDYNdYGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Ej/sC8NHTxOmYi2Z+9NfpyfA62vDJdj4sT3rusOObZamnrLz
	0t1VRAjYN0p/+0J4Oofv2HDGSwihoH7he3DRbclxtw/Bm4g5bXl3ugNBNFMKAIY=
X-Gm-Gg: ASbGncvIUpo1cHLpKprKt93OMkVCuhJg9omjJoZuyr+HMSa0kJbG7GGgKoTyM+5wpuD
	caMVv4Qbs5JUZ0SmvPLvDq9pCT3pcYAnw9HrpCtj7gmLj4M//AnKCR2QHQ4ShfV3Zna4ClKJEcp
	r5FcvkaFGQ0nXOKRZD4t5wVv37odUPoALrRpKNNpG9a7WiJMNXnUPrq1IbtYc69+0mu80a1GfP3
	ZoIDF8rx8Tce3T5tMoSDG3PP/tsxdJyQ90qT1YwrwVhX26KUpdIVM4=
X-Google-Smtp-Source: AGHT+IGp4grbvGAuPffIKwRuF0sE3gDdsLgNCa2O6zdjP6Rny0gZfL4sX2ge75TOX4NmvgcuqUKbtA==
X-Received: by 2002:a5d:64cc:0:b0:385:e877:c037 with SMTP id ffacd0b85a97d-3864cec7417mr2710692f8f.42.1733927074219;
        Wed, 11 Dec 2024 06:24:34 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708becesm13526259a91.52.2024.12.11.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 06:24:33 -0800 (PST)
Date: Wed, 11 Dec 2024 15:24:25 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>, Omar Sandoval <osandov@meta.com>
Subject: Re: [PATCH printk v1 1/2] printk: Remove redundant deferred check in
 vprintk()
Message-ID: <Z1mgmT8HlkGR6UEN@pathway.suse.cz>
References: <20241209111746.192559-1-john.ogness@linutronix.de>
 <20241209111746.192559-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209111746.192559-2-john.ogness@linutronix.de>

On Mon 2024-12-09 12:23:45, John Ogness wrote:
> The helper printk_get_console_flush_type() is already calling
> is_printk_legacy_deferred() to determine if legacy printing is
> to be offloaded. Therefore there is no need for vprintk() to
> perform this check as well. Remove the redundant check from
> vprintk().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

