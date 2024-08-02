Return-Path: <linux-kernel+bounces-272517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423CB945D65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F291C21416
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC01E2868;
	Fri,  2 Aug 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KLGh4tgk"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574161E3CA3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599243; cv=none; b=IK9QcK0gkpn+oIB2Nq4oNKSk+ZzWRVGEJUCb1vNzNQTwHmPdCHRYjKb8DdF7buLnq9DCxzIUkMznusWAkk6JQSShghRNzod6TnRb4WRje7p8+Rrhy11LPdsKHK+pblHaVTj85DJfhJkdqqCxYJ89iKis8y7TUJU/ehfJaRzhoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599243; c=relaxed/simple;
	bh=eGY7XFZtFg/M4kMWtmPxgrGyTJB81Ij4kmn8qdWRydA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chsWMkVlKAB5E+M/CHjx+J2E5jig7LHdkV6VV/6xta9Ggsg/KCa4hCmp4xVdmRx5lxOJrkL0bSD2U9WqUsVO4qky/5428wbq7rhxmtMK1PsYih3YHo5SAfWoa/sFbbyJuPQtSntJjHJBom1SeNJYuca35JhB1f/y9TLA0KtqwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KLGh4tgk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso1070983166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 04:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722599239; x=1723204039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+NfXcDVXh8h+7HYVfBt8EVfBjYJ6p5l3PUwBGBdhK8=;
        b=KLGh4tgk+DiQYGZBM4kB00mnBospAO5R22VaDyAIQkfK1s2CsfWiRKXGefMWlr99z7
         3muTwzovBrKGTmYRmmtZyH+CI4LbBpG0YsY8HLH0CLaiPlX8GIoVOYvh9NY+rGi32Rli
         M/8skFeoPvLWYe6BqgE54GhHEZbClNzEGAmWg8J8kGL7AkjBRL1GSPdvxQQlLqWwfu7a
         oFqrG3RkI7lLEvM7HaFHFKHTAtkeIY6MV86KjN16jHNV4EHNu1BItZjJPMFOTOD+TFvE
         JWQIVZf1kMmuey7WCk1prg1Is80mAczY4jmh7/SHexvQLdpP+2C3FKPK1+Bxm/SJ7RTJ
         2jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722599239; x=1723204039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+NfXcDVXh8h+7HYVfBt8EVfBjYJ6p5l3PUwBGBdhK8=;
        b=WQWBWEEZy6YddXKaMEvP4oYX3f//IhSX6dfG/NR2P9IEOomNkGzX667NWAy0yUQWjL
         i3uqmO/WzDBVJWmzxKUQvGTQD03VUZ7UbMs7nHC8dG5subhuZhY03k8BZ4JMX0tO20u7
         bT/MtVyc2c5KVKeyMZ05Uzirun6VbpAIOELdw/b1iQ+vigh1W9m1H5JQ/+7/PYbiJp2N
         ttSHi99UKRfJhoWDMKT+doZh5jpNzsSLKrKqEuzr0VLB/+8glrkl3kfAJ9FBCMnIBxwM
         odjr2qKGVu2UfLxxXw8a9TQYrvKsYhA/yIEsVv02V5/1lefviHj/W1NFVF7lKsEQN6e5
         Od9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKTKWoYkwnMeObfEfW9ggr/K47EHZw98RMUiodkQWrVaDLXlg3MPOhX4aHVCC2u0h+9oHYGqQieS9dqwrigpw4QeeE2hfSO/A04gL8
X-Gm-Message-State: AOJu0YyNcWNTz9GsoPKsRehcug8uE9z9uscaxbyPzJ+h6q5W35SfJ4Zd
	Uaeckly2MsFW3d/KC1Y29ZOdYOLI/pBO9k6DrJ074LbKAH3pYyhmqot3yJZGeF0=
X-Google-Smtp-Source: AGHT+IEacx4vAh/6iI1S6itmb/DCCV7TNxkufMxFoBoUXtDEf4od3w+2lpJVYBSCnBgOL9FYW2gZQQ==
X-Received: by 2002:a17:907:7e9b:b0:a7a:8378:625e with SMTP id a640c23a62f3a-a7dc4fa1673mr233708966b.26.1722599239448;
        Fri, 02 Aug 2024 04:47:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c12be2sm90519566b.89.2024.08.02.04.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:47:19 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:47:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 18/19] printk: nbcon: Assign nice -20 for
 printing threads
Message-ID: <ZqzHRW90yU5PfDcn@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-19-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-19-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:38, John Ogness wrote:
> It is important that console printing threads are scheduled
> shortly after a printk call and with generous runtime budgets.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

