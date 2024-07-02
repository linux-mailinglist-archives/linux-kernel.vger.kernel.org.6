Return-Path: <linux-kernel+bounces-238138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC392440C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC1C1C23DF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABE61BE857;
	Tue,  2 Jul 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnbQrJYa"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA01BD51B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939669; cv=none; b=fmTWLl9msDq+TsKyLdVzgMAKs2yrAaiQp7yuh1BgDoBgyUdYhDBbQRBjHTxb2qR8muprkk10owfRy3nUc0Mz/kMTj8rgASgiHAZecbwdyAZVwAudQI+hoPM20Oxq8q/V7uuBKDrcyFfQ1YH4FGDJacNrQRJM+oY8QdzFEdzphLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939669; c=relaxed/simple;
	bh=XDr9YQYhlKOyR11Y2scxGQYvxRbK+lxmQLg6JXV72vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azhQubVtrmHCWLc9EjttzhVh8GyaZJlAzRtK1A/4KAEQyG39i06Wb2cVwBsA6HBlOxG29z7uTC1XqaDO26kzF92fC/Dw+aGvt8c4UVXLmPfsjucV+c0udPt6IgTnB52sDRPhZkyEV3fE/la+lFNW67noyJ5n+D/GSVlq5kURnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnbQrJYa; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2614613a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719939667; x=1720544467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlFIWIK6DL2ASXsfWDyL2HrAzmzB780k9YgNw6LGYb8=;
        b=lnbQrJYajH8VuPoXzUiFQwtNEpk/OT2pq30d+zMRqIvvieDpihRn6kiTFaJmiWI/J9
         RVdl2qb6eFRil7TyfX3gENOjsl00iGHVOpm0gIt4Asa2q/tHGpE7mmYW3Z9GQnDKRxUW
         4i3jtQhStCRaKcWDssbQ+RG5xyig1VFjdN2F6HnRZEU+0j1s5b+f7TBw8AFC0CHgPwvT
         sXL23FnZ9U4BzFWURaWV7xoY3p74XwyAESklz016TnpZTU55+XEkIzbKHlWOUtmbatft
         MXCIEGTRjWYzOzOOu/THzNYBLntSom07PGbHGtvhH0T7ut8Y2vnQfimbflnGvpzpSbD/
         LzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719939667; x=1720544467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlFIWIK6DL2ASXsfWDyL2HrAzmzB780k9YgNw6LGYb8=;
        b=iecjHJOVeFbXVkCUQF11noZw3rD0j3V8GzK8IcqthM/PmwlXaT1railcSytyS0xEhz
         S2LYSgv7bdlisov5J8s5VlYyDJPN/AcUIZyiGEUMYUYUTfu0qL18WkXCaZmFjdxsPvv4
         jPSvm8RTdS02LrRg2Thi09rJeWllZ1qMv421bM2pYRfvE/jIly61aD5lMFdn9J4VHxRV
         i1+WY4intxZPKZW9SHlLHcFxK5jzHGi+1tixHJ/e8itIy2ARm7kCSZt63s7HfOwmPopq
         yJPDQau0X79b4I2CWmtzCkBBbYPhVzY6Uqu3Nkg23iU3GGioUxNmJ88OOIEEafdvI1/o
         cjCA==
X-Forwarded-Encrypted: i=1; AJvYcCVgFh/OCShEg46mF5m27MuXjOYPmucuwVLon8Gu/f9z2k550tPWLLfnY81pFPdWjV0zUtJr8t7dcT+Ye3pBR6ANck0iHUCcCp3weCob
X-Gm-Message-State: AOJu0YzytsMQoOKaGfCFF5rJ7hbOcM8/36BerXwuqqZBGZcyE3I8Ze+o
	7P5Kx6rvtfmRkuuHOaDG9BzaVlK+fryJ8qVHViuCzYTGh7AZvdyt5xOM4w==
X-Google-Smtp-Source: AGHT+IFR+qicQxtN3Dk2sOiLIbXwOyUmJt2x1qaWFscOjZwTFB5UREz1Q6jYVu/TPIIdONAkp2XPhw==
X-Received: by 2002:a05:6a20:da8e:b0:1be:bff2:b1b2 with SMTP id adf61e73a8af0-1bef61e77aemr8983024637.46.1719939665487;
        Tue, 02 Jul 2024 10:01:05 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246ee80sm8786116b3a.69.2024.07.02.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:01:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 07:01:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.11] sched_ext: Documentation: Remove
 mentions of scx_bpf_switch_all
Message-ID: <ZoQyTW44cpW436qx@slm.duckdns.org>
References: <20240702083839.176996-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702083839.176996-1-aboorvad@linux.ibm.com>

On Tue, Jul 02, 2024 at 02:08:39PM +0530, Aboorva Devarajan wrote:
> Updated sched_ext doc to eliminate references to scx_bpf_switch_all,
> which has been removed in recent sched_ext versions.
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

