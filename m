Return-Path: <linux-kernel+bounces-327495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 212449776C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79895B21D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9F1D2794;
	Fri, 13 Sep 2024 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmd40VmH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02A55886
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193486; cv=none; b=qADTnvzmIW15kMIjBoXJoWMMYRw9otpAZyHutXmB3/4aC96rB9i/5zuEU2vDo7Dlo35bIgsYwrvWI72I/2po2ObyoHlvkiehEisn+CjL3dXIhzy4vLxp9efg/ttqnhcWNjqMBMcc+q6tAJD3+fG9RnDBFnMhtuhf700IFjqTCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193486; c=relaxed/simple;
	bh=+g+iYLsDPMNU1DGfwkevSBUgkSvkrTNSbSdY7kviCWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2s+s+qtVvqWyUBenpRH93+kypEWamu8X8pU2/SF0HbIHCiukRCnIEc5i8iPyceTRkIX325PklpvvLf36NlcEWNcVQRdKuUsefnh4tLLL4bHsSxzk302dxIt7MG2vaVhrZG+ojyrYksL7/SBu9m8h1vZSvz8lQ+2OAzJ8ZMwL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmd40VmH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2057c6c57b5so9570715ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726193484; x=1726798284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VKXxde7RE5OYjcQSsDvsckGBTQR5Rmzs2NTJhqDpLY0=;
        b=cmd40VmHnWh+Vxf//d05TSDoqNi4SY4Z3fZjzmitYO8avOZclCFMEZFB7DkeJiYHy7
         +JRzvqtbtAppPdI5oAlaq7MigJED1J5mxofOJzZPbV+M9tFm/ZlFi2yvEgPcEbJ8qus0
         SxNyZBcQrKUJauNBjlJ4l0Nf0VdEYKzabpnD3olx+FKN+jxTdiI+F8t9QRy69UJ0QauJ
         VpW2vfs9n6FNdKqDIQ/EvGjZMEPBb3OqVHv4X8aQhZU0WzDiYaxlZk6bhmkkWP/a2gi0
         zPQlFuvU+FgyaAibyYwTiJBbthwdAg+VirNgYUTxsjwMhXj9oQCBvtlHkchnj1LR8yxy
         XTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726193484; x=1726798284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKXxde7RE5OYjcQSsDvsckGBTQR5Rmzs2NTJhqDpLY0=;
        b=J4krJHohKwz2fltUrR1eld9vbtX4jC9N5pIs6mW2xHRkKhZTR+nw1Kw6rtEhqyaLFu
         1oISmo8ukQySUjevrXna+IwMjlhM3O2l6TBbsKmkBEYW3F/QG4GzU0clhTie01Og0USR
         QLCjI1/m+L+SK/ix3Hr7y6IDjLHSjnpU9rvPOFTEfBbH7/e0RiWFMAi2Qx2bj0Zlo1wx
         6uqzHsa4uMuxsTvyxwIZy6AhgPYOW0M0kgrnbWFBHhIdAdn4ttAWJnYt1AUjhZqdkO9N
         FlpXzTjchi+uZirDM7gMK4vCJg58466ApPDdRm52GcBgk35jRrJ6aWU8o7Et4a7loSDK
         h3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCQ88CpWOtgybom4eP0bM4xZ6LA+pizus5CgKTorWJt/V5YIji/mnzfkYIYAWnOcNwFTT2XxRsjU1LMkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7QMDQEdSoHJ5MwIvdU+4CEaWJl4d6L4zOSzn0e7HvPQ6Uidc
	aR87cFefJzAW/gGFJZmkPxs6zPtYyh3GWpa8kGEYRhe9VsNTjQhD
X-Google-Smtp-Source: AGHT+IEqrZCzRb+7n3J3P4T7vXPxWSJssj5ZmpmeBBQjEtUecyl2Bpb6qoxteoq3R1rJwSoV4Mle6A==
X-Received: by 2002:a17:902:f684:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-2076e592912mr64011855ad.15.1726193484186;
        Thu, 12 Sep 2024 19:11:24 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.229.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af478a6sm19925485ad.102.2024.09.12.19.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 19:11:23 -0700 (PDT)
Date: Fri, 13 Sep 2024 07:41:15 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: "Ricardo B. Marliere" <ricardo.marliere@suse.com>
Cc: gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Use new initialization api for tasklet
Message-ID: <ZuOfQ9JxL71s2JFx@embed-PC.myguest.virtualbox.org>
References: <20240912172231.369566-1-abhishektamboli9@gmail.com>
 <wpmjgqvxzzowc36wtwxlht23pvvuzdpijhtkiojlayr66cktxp@dnj2ss4fu6x7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wpmjgqvxzzowc36wtwxlht23pvvuzdpijhtkiojlayr66cktxp@dnj2ss4fu6x7>

Hi Ricardo,
>
> This fails to compile for me:
> 
> In file included from ./include/linux/kernel_stat.h:8,
>                  from ./include/linux/cgroup.h:25,
>                  from ./include/net/netprio_cgroup.h:11,
>                  from ./include/linux/netdevice.h:42,
>                  from drivers/staging/octeon/ethernet-tx.c:10:
> drivers/staging/octeon/ethernet-tx.c:44:52: error: initialization of ‘void (*)(struct tasklet_struct *)’ from incompatible pointer type ‘void (*)(struct tasklet_struct)’ [-Wincompatible-pointer-types]
>    44 | static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
>       |                                                    ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/interrupt.h:665:21: note: in definition of macro ‘DECLARE_TASKLET’
>   665 |         .callback = _callback,                          \
>       |                     ^~~~~~~~~
> drivers/staging/octeon/ethernet-tx.c:44:52: note: (near initialization for ‘cvm_oct_tx_cleanup_tasklet.<anonymous>.callback’)
>    44 | static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
>       |                                                    ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/interrupt.h:665:21: note: in definition of macro ‘DECLARE_TASKLET’
>   665 |         .callback = _callback,                          \
>       |                     ^~~~~~~~~
>   CC      mm/memfd.o
>   CC      fs/proc/fd.o
>   CC      fs/jbd2/transaction.o
>   CC      drivers/firmware/efi/libstub/gop.o
> make[5]: *** [scripts/Makefile.build:244: drivers/staging/octeon/ethernet-tx.o] Error 1
> make[4]: *** [scripts/Makefile.build:485: drivers/staging/octeon] Error 2
> make[3]: *** [scripts/Makefile.build:485: drivers/staging] Error 2

Thank you for pointing out the issue. I’ll be more cautious to 
avoid such issues in the future and will resubmit the patch.

Regards,
Abhishek

