Return-Path: <linux-kernel+bounces-348057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60E498E20A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCD61C22C21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92DE1D1F4F;
	Wed,  2 Oct 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JciXZwZP"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41721D1508
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892296; cv=none; b=mv4bej31nrpCBT1MmLMohN8knMQ5PkqgK1nDc7HNNLakTI87186btes5urD/M8wUe0CSUTDZgz7+1a0acys05r3ryGchI2dg7XsC5Zt+6pdU3ZFOMjlxubhzfRAXbSq9H9Cs3RSfNY+Gfmj2DdetmvYN+QXXv2p+u07PDC25NtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892296; c=relaxed/simple;
	bh=lby/1A8fCq7mHejLsCuHfKeIw1KTiGWIaadnk8Y7lTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaO66IdBJKS68Wrz04/1dgnYRKn0H2fcFMI1q2rfAculmIEkwVlhqwrZib6a71SUx6Y0iVx+FBlulKuEtD4/d/XfnYDN7pS1usQAUBGypdVtPQMpdJkwxWuEWLZMBM2kVoWYK+p7d5E8aCaCjwZ33XaXi9yx0boz3RCfoDmstk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JciXZwZP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b3d1a77bbso21665ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727892294; x=1728497094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQErUJdb5F2AGT41enNIzhGQCHj7ywdDi81dtD+Bvl0=;
        b=JciXZwZP8PNCO6S/xVzcsA8wtHvnxKomj8jLpe86Ckorklza2qJHb6lxy/Kixojnku
         h1/0rJy8+bwrRiiq4Opa5KnTAVy0QFUPIhsdwgneEpmYiqQ/SmzI0GSHU29EuLRqfVky
         f9RhHZicADvQu+Pa79Ox4RuBUssHgek65pd1jNCTVNu9o4VgG/8NYXKPegDiSnchIMqc
         K9mswe5GafhhjcYexD3aHxpQuv6stmPD4SqLns754yVod/uLRqVoojpWDqR3LhfFGBFI
         3u5b3SeFlf2x0NCmjAdT7+143B8D1NqNG2EEBJFDi6BZxEqKYmBLjjrVEKBcowc/tDWj
         78Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892294; x=1728497094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQErUJdb5F2AGT41enNIzhGQCHj7ywdDi81dtD+Bvl0=;
        b=V6UzIvBHWWYRaqH7q5SU4+KsR4E+czmNDiPnF24zIsXZZEcQEvtmcJGuBZO7YMAsVl
         ZEZTCtpl5o1+63jzP6xUCg+PLpALWtxK0sWPz8NaeiK/dYZK0kH+wCPwJ+gnT/CE3xDh
         loopUGRIF9GM3k7J9sIPiO2q0uC/JZiX4/imMjA65VZIudUsgG/x7v8Fsn0l3Z0PFsc/
         0CewpHH8ipoi9KxS1Lnoj7PJ/Izl0lCiSpzUWvwCzWr3B/ObNxdm9iNyPPCOcNxLsW9L
         5NHmnywIIc6wpYvkeNTPErNy6rrVRWWmaV/iNX3xqpngqgzIdHmVgeLk42Mpjk+fCjFh
         jO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvr0e3WE8f1s5gEcwEBFSZXC+dwL5jHgCexB7BvxXh9wEg/zmlFqNKR7kwS20SuiRloul45eCIhOM7MRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJL6sani3E7krKpHLdMRH1C1YgkV2VMJuRkZizPBmjXCCoMhvN
	zxJS5ak1zBafHIAd+AgP/RNirtNMZ1/RoKY9K5AHeKqyjn8Sg8C5dflt1N1+HQ==
X-Google-Smtp-Source: AGHT+IFA2J4NCcAwJ1Yqgjr/2HW3TOcOGMK/sJOfz+uv6ew7v7RBKzHM4RRLMhmW24B0UpQls9zCIA==
X-Received: by 2002:a17:903:1105:b0:20b:b48d:6ae with SMTP id d9443c01a7336-20be50700damr72585ad.13.1727892293552;
        Wed, 02 Oct 2024 11:04:53 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:5c87:6cfa:74e1:b497])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649b0c8sm10058250b3a.2.2024.10.02.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:04:53 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:04:48 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Improve memory usage logging during boot
Message-ID: <Zv2LQLsIC1y0bCDL@google.com>
References: <20240930184826.3595221-1-isaacmanjarres@google.com>
 <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvwZV5MDlQYGJv9N@pathway.suse.cz>

On Tue, Oct 01, 2024 at 05:46:31PM +0200, Petr Mladek wrote:
> On Mon 2024-09-30 11:48:24, Isaac J. Manjarres wrote:
> > With the new logs, it is much easier to see exactly why the memory
> > increased by 2304 KB:
> > 
> > log_buf_len=512K:
> > 
> > printk: log_buf_len: 524288 bytes
> > printk: prb_descs size: 393216 bytes
> > printk: printk_infos size: 1441792 bytes
> 
> This should get updated to the new format.
> If I count correctly then it should be:
> 
> printk: log buffer data + meta data: 524288 + 1835008 = 2359296 bytes
Sorry, I forgot to do that; thanks for catching it. Yes, the
calculation is correct.

> > Memory: ... (... 733252K reserved ...)
> > 
> > log_buf_len=1M:
> > 
> > printk: log_buf_len: 1048576 bytes
> > printk: prb_descs size: 786432 bytes
> > printk: printk_infos size: 2883584 bytes
> 
> and here:
> 
> printk: log buffer data + meta data: 1048576 + 3670016 = 4718592 bytes
This is also correct.

> > Memory: ... (... 735556K reserved ...)
> >
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> 
> Otherwise, it looks good. With the updated commit message:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> 
> 
> Note need to send v3. I could update the commit message when committing
> the patch.
> 
> I am going to wait few days for a potential another review
> before pushing.
Thank you Petr for your review and for picking this up! I really
appreciate it.

Thanks,
Isaac

