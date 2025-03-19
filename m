Return-Path: <linux-kernel+bounces-568298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BFA6936F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D443BBFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CE1BD9C6;
	Wed, 19 Mar 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F7oM9l28"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B41C726D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397995; cv=none; b=tABmpa9ziSn8C34rls6+s/UzsCpFx1GqH5KC8lQejYKE8RG11JLRsvP4iNZh9F7vqq1uRJTpElKxrk+jtI57jr2ORwDLBlpQYDrjCPG7bwydj2fwAVrmnWvKt1P+Cfm6qmAIwhM2/J1nQcz6B3jsc759t3xbg43eFcXeylXm6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397995; c=relaxed/simple;
	bh=b6OGf6ty07rhqd72Rca7OnvW4KUA/qKgWWNZmFcHBF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cds2R3LfqzC2LqVxl1wVuy6dCAcoEIticoQCYHWobhm4J275QaTrZcNSn5KrMpvLVmZYpqY8DiigDcDhGNSSWwAHd8cB/fIxzaO9NDjh1dTKHU8xv2BjWh/PmdmRUIyXeMbf88xBUgoDb1uW72/SAxR/NT89/4lvf6gzMAuDorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F7oM9l28; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85db3475637so29468339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742397991; x=1743002791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6s7stxj6j02Q9GM2Q+eifwtx2fkSLIEYuHEkF4Kxt0=;
        b=F7oM9l28PN32B/udFja7KBDY4deoNldFRvcNzN0nXA3ZGQoxW0WkOhvOrTLQIjTFhX
         kcFOX961epeGJdJkW5dWlUTNJ4OzONPClAtI/eHUNcuxbH8DkvMLjreaWfb5AhDYqEjG
         uhChtoWVGJfyjm/3GqRBa4jwhXjT5dSn7OPM4mtNaGPqjRM3/x/B/fs9eTkLA2nPDhii
         qAkKO+wy70ZPomeK6H0s8yes4HIAXlmEO9L/egyP4o3lkqkLJw/Vm3LMxc6F3F/emHPr
         gJEeiaiDsZ2bgFy72rj9gMyx8rimUaLRWHufduSKMPvKa6hSaHXO51F1LxKdaJPM62Lt
         Q8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397991; x=1743002791;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6s7stxj6j02Q9GM2Q+eifwtx2fkSLIEYuHEkF4Kxt0=;
        b=hGLOBZu7X4NCaIHkI2xsXBWQeu/EkABfGq3BDDNn+05JKlNDc7i6/hHXJuKcLSQwon
         503Je+zXkSHyVuzxy1by7RMUqal1oia/yur+bUEU5O7LTIzNlZCqs2lsSpjFPFaZMcmI
         uhJGW7qkVXoePLS9rWx0Gm65FjgdGIIH+l63aal1AtKuzuESpcmq8sa1SnwThGtNBVZY
         9dOI1GCEp/ZBD+KQ5Mqmi6ZETIKzz8X41n1I9sPWOMwEe4Wep1PrVhQdbvM8BNFnk+pr
         wZAoDc+krafu2Lv7fhNjkq+7sxZO9L0zQh12CifKAWv4oQB2SOQD5v0Ac7dDEqY7mjb/
         H/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1gSXemShGm91LyTNl2/m5nby2k/Ao9bs6bpwawMLVxx6bBiqyqqYB6b5uXE2ybBNionM0filint8JFFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD5Xp6TtAzqopFdjLRp7x+cx6dSIZA94eNxGtWvv3f1mvD1Jr5
	9nSYAOkVd0kgtnWhlcQbkLpHvP17klIWxXjAeQacQM/ifhZiNFsJQbjGKIc/Oc1LbfQX+UQ98Ms
	l
X-Gm-Gg: ASbGncv0jQrGxANMvtgu217DEFIrXjUpL3vkQ117Gco/1h2oxGZ6N6AjaGr7HuA8ENI
	0LeHWoPTuVbFgVaBzpLEB/WxlTcZR2uaky5NulcearLSMAJxFV3UDS+1xk4fzrOsLhMGvp2xKjz
	3cHN52L86Etyf79ZfQ53649j1Iq+HLJNr71eOAxH6NNdzPKIzMR/GZPuxfndhH9pl6LmwUUuU5X
	ptXszLR03HeYTaE8XAl+ghmVpFpX7GhO5RVMbQfBFu3w8i0w4gzVPGCJflqyHAfohHQmAz0d4tI
	N7tf1uu04gbWc5DDjj0D+NwdtNOz8hQnKCE=
X-Google-Smtp-Source: AGHT+IEPszl/ebd/oSF2Uq2+SIS8aH9d2S8RxCBgdwIWLD2tLo1SckfHzcpZd8Mmqb1Lnvr1oYw0lQ==
X-Received: by 2002:a05:6e02:c6d:b0:3d3:d08d:d526 with SMTP id e9e14a558f8ab-3d57c4448b1mr60362905ab.11.1742397990791;
        Wed, 19 Mar 2025 08:26:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a83850esm38761295ab.64.2025.03.19.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:26:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Sidong Yang <sidong.yang@furiosa.ai>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org
In-Reply-To: <20250319061251.21452-1-sidong.yang@furiosa.ai>
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
Subject: Re: (subset) [RFC PATCH v5 0/5] introduce
 io_uring_cmd_import_fixed_vec
Message-Id: <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
Date: Wed, 19 Mar 2025 09:26:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 19 Mar 2025 06:12:46 +0000, Sidong Yang wrote:
> This patche series introduce io_uring_cmd_import_vec. With this function,
> Multiple fixed buffer could be used in uring cmd. It's vectored version
> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> for new api for encoded read/write in btrfs by using uring cmd.
> 
> There was approximately 10 percent of performance improvements through benchmark.
> The benchmark code is in
> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
> 
> [...]

Applied, thanks!

[1/5] io_uring: rename the data cmd cache
      commit: 575e7b0629d4bd485517c40ff20676180476f5f9
[2/5] io_uring/cmd: don't expose entire cmd async data
      commit: 5f14404bfa245a156915ee44c827edc56655b067
[3/5] io_uring/cmd: add iovec cache for commands
      commit: fe549edab6c3b7995b58450e31232566b383a249
[4/5] io_uring/cmd: introduce io_uring_cmd_import_fixed_vec
      commit: b24cb04c1e072ecd859a98b2e4258ca8fe8d2d4d

Best regards,
-- 
Jens Axboe




