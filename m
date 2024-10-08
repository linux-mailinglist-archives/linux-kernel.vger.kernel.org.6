Return-Path: <linux-kernel+bounces-354543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674B993F18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4847F280D43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047A1D358F;
	Tue,  8 Oct 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwPpTKR0"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B231684A4;
	Tue,  8 Oct 2024 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368707; cv=none; b=WNslDjMSiR+s+eXDWDHaW0l8ojnDLBYrSF7V4q89z6kvHxVkCIHgjwIGQmT7Z3dPb4+mk7KCcbvf6SP9cQWWCpGpeVLJVtvU388Fik4pLta162FSRmL8xkbmX/4jRgAKxWAr27spJj01MUxa75lRU5J3bHKpSR9RGsDX8PHyx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368707; c=relaxed/simple;
	bh=uFy2vpul7G/GLwNv9E36WWSZkQ1MiEtCDpcx7+WMWh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCJeTlP3/iu7BEgSpuodwmmEiwOwWnZzUAslbPYfHOB+zMTPBGJox6W29sfA6wKpak4HuLVinY9GxbznVSm9h2zQsmoU6GhKwQ7RLBOQQBWdRAR07tkA8qUojBzj4GlTgewJMRttZ9q0CDsjOF5gFPvEhrKGRehtHCBFCGsSRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwPpTKR0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b7eb9e81eso62574075ad.2;
        Mon, 07 Oct 2024 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728368705; x=1728973505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcO0kclRnti3T2Fe8Q/2qn3o4aRc8CbVApVxuVxO7eE=;
        b=iwPpTKR0Q7z3dvxJ4hJHXZ8Iv4UPgZxG6RMPRN8d0pVfTcE4BKxQQOj+eeFqz+stKd
         jDAwgz8qBlzgnrtFLjVAjEIiYs1S+p8+MyG9XSSPIWYzTjWjZkfgvMksK2UUqI8J7DQO
         p3ILzJTlhwnOI+M1wHIiCR1IZbW1hMoY57xoUKRQACaV5uzL6oVtf8qTwr1LtsWbBxX5
         YV9QNmnedyp1E8sl2YEAUL0voB2h918jGXi+nvDdD3hNB/h3U4JGAxj/aNV7QymYZsRz
         fU6/quSDOhbyrLoBehbPdOq1FuF7o7NEhG+tD25SX9I7QT6f3KJPSYAMha5iMsju0Xgn
         FC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368705; x=1728973505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcO0kclRnti3T2Fe8Q/2qn3o4aRc8CbVApVxuVxO7eE=;
        b=DKXY+KO2jMuVjtwQM363oYOr79y3cbhoXvJ1Y1+H3hsc7Q7x5PglVNDgBDwOYcIyH9
         OTyKH2RO0YlBJItSPCxHdFFnKmu6qoss/PatBPNOF0sb1d0qho/3YHkezDqbtTGt+Mkj
         qTwPBbobQT+SSNFxW0utdNFPsLqB5me5qn13H/vDS1sk6qKHpCoXi9w3stL5d9aeJHzX
         BaDKyVxPtymHl7gpr3qaHqJr0QjcwpCtqaYHahPM1573G24o2cetxj/aZ1JTqK6ZZIgq
         kcP/Yecz/BmUcCpm4xcoBR+bvydZEmIz6jbQMy6gOOiT1DAUEWyl+l10CBqtLUVDNxLG
         XbhA==
X-Forwarded-Encrypted: i=1; AJvYcCUrOUkQGNzb9Fz9RlWPCFd2VC67NNz6Avl410gkyzajWMU2gX07DsvrOhVW6PPuHkrbQWGpjmoxfo4FLPcB@vger.kernel.org, AJvYcCWj/r8YHNzrvl/PAfU/RwbC+lolSNjeg9qOtImtqs+zi7XCp2+dxggvwh/FsbFjnGpbPyex1WPwkptz@vger.kernel.org
X-Gm-Message-State: AOJu0YxBWAstpyohIn3URnsCYAuXxtxXqy+cW3i37c/NoTgWXg6Q4XgR
	5sOfPRWedfvWFF40s06F+VfeEefZRZsmdrDmDpWR2DmTAlIZKQda
X-Google-Smtp-Source: AGHT+IFd5xP48KgBsGIGdoRms/LeQ5/eyjLYz0VcwFnYcHyE9Ih7SovMGkiTJt7oGRMISjZ/fOOfzg==
X-Received: by 2002:a05:6a20:438c:b0:1d6:2378:58ea with SMTP id adf61e73a8af0-1d6df73047emr22040511637.0.1728368705335;
        Mon, 07 Oct 2024 23:25:05 -0700 (PDT)
Received: from inochi.infowork ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13971c85sm49367145ad.239.2024.10.07.23.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:25:05 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:24:56 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, 
	unicorn_wang@outlook.com, conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com, 
	krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com
Cc: Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 0/1] Add power key for pioneer box
Message-ID: <kmmnhqatth6uhr54jcuiuy5shhzdq25msyp6muiih5gchfytky@dd37ut4uv5xy>
References: <cover.1728350655.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728350655.git.unicorn_wang@outlook.com>

On Tue, Oct 08, 2024 at 09:43:32AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add power key for pioneer box.
> 
> Thanks,
> Chen
> 
> ---
> 
> Changes in v1:
>   The patch is based on v6.12-rc1.
> 
> ---
> 
> Chen Wang (1):
>   riscv: sophgo: dts: add power key for pioneer box
> 
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> 
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> -- 
> 2.34.1
> 

If the cover has no meaningful information, you can send the patch
directly and put the changelog in the patch under the first "---".

Regards,
Inochi

