Return-Path: <linux-kernel+bounces-322496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA6F9729B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923A01F25236
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33081175D50;
	Tue, 10 Sep 2024 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dN1GDrmv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDA12E48
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950504; cv=none; b=o4hhKBdt622VebrjjEnf3yhfIIjF2tm83bBvGsB3F2lbj6wDYnb+vi4Y3b0yp7d1OOEISnz2Klloz/bkNUzSPfL5bCopaWEAPL4ShHxtjqBLu3lK8jfDsQuqXHpB8VwLF+6O669dHA/BG2F19lWGlO+tdSbK0+mTSYZnoZzGc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950504; c=relaxed/simple;
	bh=FBzfQUsn7gdsoZ8r+kjcTGSp/lT6QLipS/PybtuxXlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTgA/nR1GcNWwcFmK5U8PLkJ8CPRqXMrvq8v15fgnZlKu9rZpneL3icxv8MnBkkaMX3Ri5SGHHXQS0ErBMAmyMx8WLGJ/eg9cH1j2VBTEP62Fgh56Xp6rsNbG0nlKKUsfMQPh4yEydHfTzPGTmYnLiPxBMVVRWk2LYBWruptuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dN1GDrmv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso5192509a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725950501; x=1726555301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAgRt71Fsjo5jfGgL2gtT96OizHcTljnrVuSnLm85h8=;
        b=dN1GDrmvfKeHSSb3oOI0B2qagpsX/hkzXQxZ8KBmhAKTjY9yLYpHwxE+4jNOpGdM88
         cBiLTTV41Bb3RTU9ypcHm/ViNgFRBwXTbrMeSEWNl4InySXZQWtpeMyiDnGjSBkD3ROW
         J6epOmczn0X0m54JqsiCX8NqGnYuHvoC6WsEGhDfn9Wpoo6dls6ey5uU/vBn6Aup3dIV
         dfVPg7TIqHXjQkrXY25wJ4oUm0VnQjcylEjGCf+SOHtDrFpezeh/v/I5fuHDRyVy9/sN
         Z3ve2pfdIuR5zwB8myQR+5J1eAX10MXM6J/IsSey1tPVR9+FRk5hTveSo+FiKWTgCnUV
         DXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725950501; x=1726555301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAgRt71Fsjo5jfGgL2gtT96OizHcTljnrVuSnLm85h8=;
        b=e4FfJ1C8Tu6FcwaN6comvS0Kwy5BQ8+QSsgj4GRKWD8XHu3JyfTMoAuQbUkBTcsEUX
         qvSeC1knu/zgJyIFDQpyd1SQ2n02ueF2pQMMnMBk/wmAdawbnC9zMShMubUR1mLRvVtH
         Y2qPGlrgxazR2e3UYdyYIzVoMVVyTS5yyffKIuzHILrsK2/Q8n7IfRonZIffVqtRhBGt
         lBheuHYUiEy6Hl4P6o5xlYEyegkzAJ5yidBXUnmqPjxaxmmqc3lDmbDvnU0edLGz+W2K
         OhyLRkiQD3CoYEU8qCNNkJYaDNiiPSaGTrso5m27gzb13EWOTJ8bR74QYMYgaOL5I51h
         K2MA==
X-Forwarded-Encrypted: i=1; AJvYcCWDXqcSV89RhrYYoipm12SkOt18FfpDE6fpkZrBRR0RjXUkY14Rk224O3jiqUDL+RHcubQD+oTUv+FsmK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKz6rgs5vc/RM/8reZUhdCcgrGbkyzpzRkT7cERkBFNApixcNU
	vDnJ0u/s+s8E1kzVle8XzInYRydbAHZjmzoJOp+Z8wL4NkBHF/zKOA8028jWLUQ=
X-Google-Smtp-Source: AGHT+IHynW7O/4dai9zZtMPbHvEnDZRsDNJ5seAKE0gNhwOpFUukyt3g6aqw5PzDqwN+Dj60wdYeHw==
X-Received: by 2002:a05:6402:2115:b0:5c4:8ac:ff80 with SMTP id 4fb4d7f45d1cf-5c408ad0316mr52313a12.33.1725950500707;
        Mon, 09 Sep 2024 23:41:40 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c408bb12d5sm7097a12.70.2024.09.09.23.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:41:40 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:41:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Yu Liao <liaoyu15@huawei.com>, liwei391@huawei.com, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] printk: Export
 match_devname_and_update_preferred_console()
Message-ID: <Zt_qIssr_jukJ4ey@pathway.suse.cz>
References: <20240909075652.747370-1-liaoyu15@huawei.com>
 <Zt6xFlLyBgLhIlDU@tlindgre-MOBL1>
 <Zt7UXNZC1UR2t1OJ@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7UXNZC1UR2t1OJ@tlindgre-MOBL1>

On Mon 2024-09-09 13:56:28, Tony Lindgren wrote:
> On Mon, Sep 09, 2024 at 11:25:58AM +0300, Tony Lindgren wrote:
> > On Mon, Sep 09, 2024 at 03:56:52PM +0800, Yu Liao wrote:
> > > When building serial_base as a module, modpost fails with the following
> > > error message:
> > > 
> > >   ERROR: modpost: "match_devname_and_update_preferred_console"
> > >   [drivers/tty/serial/serial_base.ko] undefined!
> > > 
> > > Export the symbol to allow using it from modules.
> > 
> > I think the issue is with CONFIG_PRINTK is no set, and serial drivers
> > select SERIAL_CORE_CONSOLE? And when serial_base is a module, there is
> > no kernel console.
> > 
> > I replied earlier today to the lkp error report along those lines, but
> > please let me know if there is more to the issue than that.
> 
> Sorry I gave wrong information above. The issue can be hit also with
> CONFIG_PRINTK=y and serial_base as a loadable module.

Yes, this is my understanding. The problem has happened when serial_base
was built as a module. So exporting the symbol looks like the right fix.

Best Regards,
Petr

