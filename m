Return-Path: <linux-kernel+bounces-421468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519339D8BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE472165D97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C71B85E4;
	Mon, 25 Nov 2024 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOpD6FBC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E895B1B87CD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557376; cv=none; b=gPXwFbHoFZqvKdYfUDnpLOf9z0iblkgHt+vkG/U+RJamAd0ahZ39b2yYQckc6cp7CB+qsuP2G0+EymmjuTX0ppgXLyPfvytozWinWHU6TkzWWRN4wHlyF0bTNBxApnEwFjGCntQn+3+HsUAfK6GAXIXqzQefTatTxUDjm7RfFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557376; c=relaxed/simple;
	bh=e4NJ9ThR+myalwvbOY1vhH8hOxYL+eKpZ+2VNO556mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onPAWDCy5gjT8adADcU6Z6KBvxVbQzPLNAoCFbRjX7RKNbBbw/S193V5TgJUr7BBrpqG+bVPQc0U+tHxGkiTCOXaX87cN7VrSRIgjYGOjHPDBiirjQ+oE0hsLE1YPrqpiwPnXeTSrwjaO+EWi/QPEdGkGCAQRsKwFTUwdghHs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOpD6FBC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724ffe64923so1933326b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732557374; x=1733162174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwOT6QQSrwG/cTZ2ti35IJ9oZT7dv9UB5scn5A3d/XU=;
        b=KOpD6FBCYuTwhYi+yoFzoxOf9LAKUyajUUB7LvzFFwWOFG2E8WUFqQd7BM9gsRw5AZ
         V4s72J50eK961YJNO3Rpk9mGbQ1EaXuNGmBuhOOYKCllHfwzDFbc186NC+9uvNLQOR3x
         1LXnwqa8V1mf9ol3pWl5h85augoyLTWQ66ggt4WWAtN6UrRHMRKJOABusKiJWDFucmUQ
         +TcKTofjoab/dIjOE5Xuq/RdPOrEyWh4m5m92zPut22Qe4snGF5j+H0EZakj5M2KLxnd
         IPvhk7Pl2PJ4mAX0pZ7cTi7DhnJRFLLbtWHNrZWc7Jv4165uiOXNjE1zYdUf3JZfmB24
         afmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732557374; x=1733162174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwOT6QQSrwG/cTZ2ti35IJ9oZT7dv9UB5scn5A3d/XU=;
        b=TBrZX3AtJLAWYm5K+ovQqyFbuCCPFiUItmrgjBcOrbNXASKzmyvQjNZWNU/MeOq9HE
         Uql4mU6HExCScFCcjQV0Wg3ALV3J/B8PzQ+xTpUR73H9T1eTHzAnbx9hb27k+heetowY
         t/eNSpiYJoLMaTy2NBxQt8zH+vRZ7WLLeDL5MNFC6sAHpPL4pPLtq3SYCea3j0YuUlUK
         i99f2gjDttBtDKGbSZmYKgKBQ90Jxwxv3CYF0lul+vAc5NTV6uvfK6evXVbTzeALG5FN
         D4MqLIi3a3B8d9mcAay9DfGw5bIrOm6U6n/IsebW2HJPhbHJg+fdlYfUoHs1B1YEhoRI
         uAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9v4lBjKKQ9ODMoxXyxPDXw1Q5/UdxAADiYWJ08sNYyhf7e1D7KiV/fz+aTwK9rOHhU/fEIDwDctRae8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0kr9bZWF9d0TJzs3UwgcuD7gZ1SLe2U+OzUTINpLFQah23dv
	WnpX37UMbYO/qqyqtApghEZR/usyir4T6IdvSN5tbDi9KftDK2en
X-Gm-Gg: ASbGnct0bMl5/CVopicGoVD0um4bayiS4tcfEyylYH2cvCVb3ujNQ3TaFPZVmB/ZKPB
	REjhGU88lZNKfDHzk8VF7ihXJdcuX+xt38hEyX5nQpNHwWNGI59T+1smSsupEXpmdY0G5SiDC0S
	mRN1XfhLWFx97Reiebgxq77A7y5PJGRu2W8xGNb1S7/C34B22AJkLddvx7rSdIcg/0repdQWAS4
	gt0bk61KYap+02T07ejr4PYsGMCy/6TwSNWzw==
X-Google-Smtp-Source: AGHT+IEZ+nafAqL1hXYBb0A9DUlays7oUMLPAEGJkcpQ3NA6AAy1BuUS+Aqzzg7+AZcRdswtRLnhcQ==
X-Received: by 2002:a17:902:cec7:b0:20c:a175:b720 with SMTP id d9443c01a7336-2129f65a8d7mr212913395ad.1.1732557374096;
        Mon, 25 Nov 2024 09:56:14 -0800 (PST)
Received: from tc ([2601:1c2:c104:170:2d2:ed5d:17c9:e364])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc17554sm66434065ad.208.2024.11.25.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:56:13 -0800 (PST)
Date: Mon, 25 Nov 2024 09:56:11 -0800
From: Leo Stone <leocstone@gmail.com>
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Add check for deleted inode
Message-ID: <icjuhtz35zvp5j6zvgbubydbmirbsr4ceasgxr3rk333bj55dp@mp5yf532hd4i>
References: <20241124010459.23283-1-leocstone@gmail.com>
 <1652260c-7657-4f40-ac79-027666f512f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652260c-7657-4f40-ac79-027666f512f0@kernel.org>

On Mon, Nov 25, 2024 at 07:16:41PM +0800, Chao Yu wrote:
> 
> I'm fine w/ this change, but I didn't get it, how did above commit introduce
> this bug?

Hello Chao,

The commit from the bisect didn't exactly introduce this bug, since it
would still be possible to make a different image that does the exact
same thing in the older code.

This commit was blamed in the bisect because it changes the layout of
struct f2fs_inode:

> @@ -271,6 +272,10 @@ struct f2fs_inode {
> 			__le32 i_inode_checksum;/* inode meta checksum */
> 			__le64 i_crtime;	/* creation time */
> 			__le32 i_crtime_nsec;	/* creation time in nano scale */
>+			__le64 i_compr_blocks;	/* # of compressed blocks */
>+			__u8 i_compress_algorithm;	/* compress algorithm */
>+			__u8 i_log_cluster_size;	/* log of cluster size */
>+			__le16 i_padding;		/* padding */
> 			__le32 i_extra_end[0];	/* for attribute size calculation */
> 		} __packed;
> 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */

This changes F2FS_TOTAL_EXTRA_ATTR_SIZE, which allows the syzbot
reproducer's inode to pass the sanity check for corrupted i_extra_size.
Before this change, the inode gets rejected as corrupt:

>[   62.794566][ T9662] F2FS-fs (loop0): sanity_check_inode: inode (ino=7) has corrupted i_extra_isize: 36, max: 24

Thanks,
Leo

