Return-Path: <linux-kernel+bounces-334855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86C97DD6D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA57B2146F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02114EC56;
	Sat, 21 Sep 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4LC/k7I"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BD1EB2A
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726928533; cv=none; b=d2CK3NfRBMUazmGEg9nSxXulG2UXflxuod1dpqhbmpAjat1p50/uXH4/mZrgXLL2pnHw80Sk8TgRXjkOZesvWmM/vaYx9S0Uj31jyzhmAyzbFMTpGlSRmdOmWrCeh1sMREc2e6jFKJHrS0rSc830mkR34ZqeZla63JuBIdtL3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726928533; c=relaxed/simple;
	bh=X/BH7wuMLP2jduWFdqalM+7/pujCECO1ESe3ptDETSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6h8djoJXQhyiMdlm/roz81DDD+rcsDuy3g9yAD6fKe9T+4/8wzzvBGfyPR0MS/27HrhPOUeCPXLZzoj5mz+U1Ju9FI6kClIu+jw4EXxBXUj3lDozh1/DPX54mLQDXjZp/wPoZRpGL1jRIIJ0lFFf6YBeRuCc3+T+jEJEMxXHFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4LC/k7I; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-717934728adso2177125b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726928532; x=1727533332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/BH7wuMLP2jduWFdqalM+7/pujCECO1ESe3ptDETSI=;
        b=A4LC/k7IiaeoUgRlz3uQL6lLo1+7aovv7dqPWhqZih80/T8nYKh/veytYuI1Y/ZN9y
         PjPhKgpLmvnkSH6/E0/ATn93JtAuwxQhsN6PBjgULHZ6Nt5p7VcLyPyxjUGyYWkvwF7g
         Edp9CLOEix9FvK/7WSnhexyaA7FWOV9tzOSWj4Mfu/ZCHlVTocNFYD3Mxd0dPASfUJM/
         4+mTO86J28KVQDZhmi/BtTI2AwbLfnXcvl7Hy9HNYSSL+e6MydAWaWRXOweiXaHhDj7y
         /kDpJcp6kTcrVp5BaGRbXqUHCqj/co45QWxgsI9u0+POX1Y82lRHnrVeUQJRW5EowOTU
         7gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726928532; x=1727533332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/BH7wuMLP2jduWFdqalM+7/pujCECO1ESe3ptDETSI=;
        b=KjTn0QjLf0XFYpGQYqVbi7RDV3y/MYtAILNv3Cioad2QBiEswe2NgU11DZyfN7XoFp
         1cUkG2JlXyfPqVggTUMTOv2KhZeYAQyNXh64wOdazNE4lKnynD6NjkBqWhN8r0rwPobB
         G7qwd7BQSHqY84xYDuzBD/paGnjjrbsHFcFybsh/9xxDuo0Z5OSjK+PKsSsIhe3KHvdF
         +vQxmDpwpxQai9tX9p7xEZsgXt9tLwmToRrsPKnxNyjJsq0pgD54PnWp69I2GMc7viW2
         +ASMLhxhkDKbO5CWnfaw7EducrmPbbYXYC8zJhkedvhx2opmr850OmX3jWwx0nloRMX4
         1B0g==
X-Forwarded-Encrypted: i=1; AJvYcCXq0r6ZSkEghRKhcwXOoY7712K85Wn0hrO0w6m6AMWUJMxIUxTHFnHb2hldYRZMwt1LGyxv2tAxKC6ZF9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFSk8b4V26MdJKqsfj8H8tPUNmTJqmNFo6ptPde8StdPkuet5a
	p2oH/xgE0XrqHHKBORD7uE1g2WeVCfAzbcMw+lrBnDZ34CzCzF27
X-Google-Smtp-Source: AGHT+IFuUj9YzxZhno/X2uzgCZZIYddvxL56GB2fYTWRZo3CVQzpmp2G1r9R83QfEAF+aD1AO5sE5Q==
X-Received: by 2002:a05:6a20:c996:b0:1c0:e9dd:1197 with SMTP id adf61e73a8af0-1d30a948939mr6872978637.22.1726928531615;
        Sat, 21 Sep 2024 07:22:11 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944ab50cbsm11335154b3a.53.2024.09.21.07.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 07:22:10 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: heming.zhao@suse.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	pvmohammedanees2003@gmail.com,
	syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] ocfs2: Fix deadlock in ocfs2_read_virt_blocks
Date: Sat, 21 Sep 2024 14:22:02 +0000
Message-ID: <20240921142202.4793-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2690bc1f-049f-4a27-823e-5da0ae1bdcda@suse.com>
References: <2690bc1f-049f-4a27-823e-5da0ae1bdcda@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
I tested the patch on the URL you have provided, it seems to
tackle the bug and it is appropriate, i will link this to that
URL and send the new patch.
Thanks!

