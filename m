Return-Path: <linux-kernel+bounces-170013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709758BD092
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE4B24D32
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938415380D;
	Mon,  6 May 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayj2sEsi"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B21153597;
	Mon,  6 May 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006677; cv=none; b=kejRmT3fS5r9pOb6WGRyxSGRNXrRVOcKMxnVqvWGCKkmyOaxFf9P84m3it8eYd8l1BmSwNcBzyhzejoUA9A0j0sy7QIHP4MnvZbrFXwekuoiJZ7Re0WMsEiLMYc8YmZ4W5MrafLC9RXxVUXw2BnaguvRbdPp0H9zBKXOMkSwrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006677; c=relaxed/simple;
	bh=Ke0QY5ldJbt49WMIefdFQkbFTEJLVnNZPXqfdqOaC0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMW8KV0OusCGkUfTvPRzVFbRREMSncjCjXWdnGbWi55Jyn03H/fJpnbBsTyt49Li5QBMhlL3DcPIuBeT4RGWC+5+kOJ/cHsT6A6h98pln+piEfb3lSPEqY613MTowh0L2Ab3xiFEYHg4CXZone8qYd/ry8hTfkTYLyCDJ5qrUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayj2sEsi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so2236426e87.0;
        Mon, 06 May 2024 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715006674; x=1715611474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke0QY5ldJbt49WMIefdFQkbFTEJLVnNZPXqfdqOaC0M=;
        b=ayj2sEsiNH/OPyraMffBYF2HjbRAZwahYf5UEsbLu6uhgBShwpSWRFOCThXWMSLpL0
         JtPCmN25LvikpY3dH8+VMxDyKm2iRD9i9H3Ug7gv7XzP5LVv1uO2RLeSVAjGXseaWk6T
         vDM8muAKTH5c1H48E7MBoxpIf8Hd4FlAWrrq6mJOtgPXhjEcGraW7bD8VMHAl9ZoORyf
         Qdd3ogDhLvWA2Iy8Yz8803dxOBFIKNENMNLTWwgQ2P3MhvCI7pVBJJzT0uZkftHFqFd4
         jYI5jGq2tFfHPKusgtzWCkN/x4h/DhC7M7QKImzWMHLJiTn+baHW2CR8xNknIGFFVtfn
         mwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006674; x=1715611474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke0QY5ldJbt49WMIefdFQkbFTEJLVnNZPXqfdqOaC0M=;
        b=cu3g/Pshnn5AZ9UNDFV5HPCceukwvt19kcxACjPtcAxTVipsn4Otze1ftO/4TsmIUN
         +DXWhqSrTf7Wq+JsX2CLWBzhO0YgXBZnZbJbPzPWVpn/O+E6vUhyH3ToCBE64Ch1ylta
         gj+U6gq1LzzQ1ReJYByE7DgWmpPfBWsyH+3rXpOdKJbNC7qkl/CC9nskwMNvtGIbXKb3
         EGksgTQE08Z7jAovRVYXMd44NBBbc8WvH69Pn/I587HA7YEXtcnzm0aiB6ivJZUor/Fp
         xOJh/VGvO7Q7Hn9/yggCZe+JrJQLQ2hhl1Xs3AwHiJmUuw/Ray6NztE5KB80tLRxhy1O
         YKMA==
X-Forwarded-Encrypted: i=1; AJvYcCU7LYw2FYAUGsnYrawSBWna/iy1m16c1L7r2FRbMqUEmZdF6zIgJYUrO8ZIRpJnmL2UnItBqK6CadnfAmGCy+B84cddsSbvtLsg8hUV
X-Gm-Message-State: AOJu0YyPc/2xw+oh+DORXYyKYAuOsR0NHrv4Cl/lw9diYn2wZWHq0Gvs
	ColvI4/vfP6M5eGvq7ISXguo3N6x9detT5EGJf12fLxR+vOc+kCOkxn6rQ==
X-Google-Smtp-Source: AGHT+IHoZFGoykpwAn6Raq+JnNxw5zE3k33rpC3SUZ1+yXPSc/upKVuWVJmDpMD2DRt28mM/k06uqw==
X-Received: by 2002:a19:914d:0:b0:51d:5ffd:efe4 with SMTP id y13-20020a19914d000000b0051d5ffdefe4mr8372728lfj.1.1715006673256;
        Mon, 06 May 2024 07:44:33 -0700 (PDT)
Received: from lpm-pc.appeartv.lan (195-159-183-44.customer.powertech.no. [195.159.183.44])
        by smtp.gmail.com with ESMTPSA id i5-20020ac25b45000000b005190569dd4asm1681788lfp.298.2024.05.06.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:44:32 -0700 (PDT)
From: Lars Petter Mostad <larspm@gmail.com>
X-Google-Original-From: Lars Petter Mostad <lars.petter.mostad@appear.net>
To: linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] hwmon: (emc1403) Various improvements
Date: Mon,  6 May 2024 16:44:12 +0200
Message-ID: <20240506144412.139300-1-lars.petter.mostad@appear.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503154324.517246-1-linux@roeck-us.net>
References: <20240503154324.517246-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have tested these patches on EMC1438. This has also worked well for me.

Regards,
Lars Petter

