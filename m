Return-Path: <linux-kernel+bounces-303572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE8960EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C0F284F15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B51C57BC;
	Tue, 27 Aug 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LPebize6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08519F485
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770244; cv=none; b=dS5bDRQr28ciyIBumvcmmnmWd6dNXsTG9us5eV7x3hrf1tqu2Vvi+yQO7wESOiCtnPQAPZtOKpakTpRW4JQ1F8mubDGZXQBhnXWmxAfu88s37U/HuClbLeWENe8wZ8OKRFr0YdrhYpPumb0vNdWLf1uPXo79DoQtbdQ1yk7tHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770244; c=relaxed/simple;
	bh=E/VA2dhVUDxHr0qqA9cQJNUq95/yfekHA3jWbt47R7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLv1qzEy4fEtuV1liRbvyql32jpwcS3p4xZYdy2JhccLv8YWLUfi49t1mi3aGeL4NcnNwI3YpakNsIoP4ek7Ip8eilKbUV08tk5bixe2dBFQ9zWyQtlbCpTiw+14kIw/jdTjLpkaTII6G4hBzHhUfdJqBQHki37fCySjbzqq2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LPebize6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86859e2fc0so695701266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724770240; x=1725375040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgb5QhnHJgPUsHZbYnxWBCM+bXSZRt44Qf2OG91tAoI=;
        b=LPebize6yPO2W3SM/I/oDHcMJHpQIQpzAj+EiUhy9bnkqlFSsG321Wx8zFnvZsZCs5
         xTBpIzvDJVephln3ec+juAn/yvSBKneeYB42Z5OCioObeCnTFtBsdm2shYxXTfiEBhTz
         oTzZIgxWIhMp0nx/xyxxttQBl9Pj3Kh7CIW6Kak1+xgBuEesjkZnZUUtLUpIgozIdkUG
         +0Zm68zxsLpJwr1Y+3H8ADFR0TksZtOGJ36xw/mGy9MryLTSwbKf7WwPkYaj1+O1c71U
         p828e//76rycfi7nSA667hmMTWVqmphY6y2e7jhG/uSAJsVSNFEdPBU6UAbvsjE5Q6h9
         Vi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770240; x=1725375040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgb5QhnHJgPUsHZbYnxWBCM+bXSZRt44Qf2OG91tAoI=;
        b=LurCts84plyDAwvF61B/uBUrEDyXERDb6j+5YhnHkYmOfeAZ8K/a11aI6wO8RJf62H
         xrNbbbgExKzU3z4n3bbjFAMnlXZ236I0ca4Qa2b2pOriMf+Lcx0o8VolbYHncyWvGLuj
         dWo2T9NQ3NOPASMngGblVCCGxuT8ldP4DnkaiwOss9J4C8a+xlnsSq+kcqntDc6bid6A
         iysx6id0l6V7Lw2fO9ieH7hGwUDJZ5lic8n+3BXahNpDUu7KLXKJ/ugfGCEj+YasMeAk
         aHIIJsaxjny/o142zkuIvtWdLxY35SWFlcjHTgqmBMPIHS8ZE/8weaZXLiJzZLhonjxd
         9jKg==
X-Forwarded-Encrypted: i=1; AJvYcCWi8p+BXhgXUR1DkuFzCLZt2I+NKH8ZLpymUNWNIZsReIpc3WALXsXl94hSOHP4LSLLCGwxbmZrdxheDAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrmCd1lrH2o5rAz1XaCf7SjIzutyeecB8sUK0jNnDzaio73rb
	g290Fv5GrEEIj6n1E4B3C8AwFAEvtT5zDFCvpkOSvsZzvvsGQUU8fGefUKYqaCU=
X-Google-Smtp-Source: AGHT+IGCMn73EJrlGfvP7RyjBPbNw9szadEN4qP8Bn2mkjue2t07YyLGV6jeID6FF19Ig7u+KvU8OA==
X-Received: by 2002:a17:906:f5a9:b0:a7a:97ca:3058 with SMTP id a640c23a62f3a-a86e397e68cmr247805766b.5.1724770239445;
        Tue, 27 Aug 2024 07:50:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e58791cesm120139866b.148.2024.08.27.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:50:39 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:50:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 07/17] printk: nbcon: Relocate
 nbcon_atomic_emit_one()
Message-ID: <Zs3nvV4d98iCTG9S@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-8-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827044333.88596-8-john.ogness@linutronix.de>

On Tue 2024-08-27 06:49:23, John Ogness wrote:
> Move nbcon_atomic_emit_one() so that it can be used by
> nbcon_kthread_func() in a follow-up commit.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

