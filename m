Return-Path: <linux-kernel+bounces-216613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1156790A21E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B361A1F25611
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47794176ABF;
	Mon, 17 Jun 2024 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJFTFOc6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252717C8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589169; cv=none; b=MzYhEOODJcAk8CSzXbHGWf1ZJdUWcprk2AxsXYohm2e8Sa7YHYF+3YtHYYgZXCCeT1uf1zw+Q9wui0W46b150drtUjele2/7CCPrbZOlSsuTHFYK6QMK9+naC5HuABZDCJ7OLG4m6R+OQR7B4QE1dd68qtwvJ6I+B9R2gpwlMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589169; c=relaxed/simple;
	bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHrFx/jjQc0SXCXG/Kgl9FG9WULEwIhI5RuX63WHweukVVJKtyE1IDGNxxe0CYTjws3zGqdJFAZfoLBSiHnqtUlLuYuIVAuVxIlFjaAZkxj85SZuY8D/BxVHsa635wDkukpFIUYC1+QEe5akRuFeb1vYGv0VYkE7OHYeBPqVExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJFTFOc6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718589167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
	b=JJFTFOc6HlOD1n+sow2Jigc73ftOD9Wm1kZhYkGimBR5VgqAOHUvUawgYlbqkMaDRKEGji
	4UUNXRCXPDHQosqj5YEHIsSG/ZBrGJKBZVnfILftTqc/cNhfwhAGwnRaRT/7se6h+04VHw
	HR3Urt0PVs+pqSpncWAGtS2svklkOls=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-2PKXjfnhM_mjCKGnUcHv5g-1; Sun, 16 Jun 2024 21:52:44 -0400
X-MC-Unique: 2PKXjfnhM_mjCKGnUcHv5g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c2dfb3d3e2so4258073a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718589163; x=1719193963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
        b=igCV60vqGwMU5vzrBbuxENZi4SZJgnR3YPLTM37AdoFsJzf0BFEF8+/CWKg6H65SpC
         UZlX0gUtgdaoXlSiicFn/pdrlTCG76LJsHfLv+PLWw1AH9Div9ihUdoJeTy60DIJK78K
         5huLloxiQmZX6Igy+bF3Q/1h16pJ8X1yrSVz5Vf9pr+eOFwMtKH+pokDEWL+/6HvqIPM
         awPMYJr+twe9C4gsdsGYw84ShW23YxC2OcYNa1iu7KNtlUT3WunOiid5SqmQ97UZHYj7
         V1xGGUmnsMS/SKSzAb/zbOf4MGkkAqm2ouKEm4jJDMgH7mP1vTaKhbSnSoK8nyqmVsd+
         WIWg==
X-Forwarded-Encrypted: i=1; AJvYcCU2MTtI2nvPReYs4BIv8WJulV3U3BA/uCuFsCVwNSOf7FexZIuTxz2G2zVvIg6qMoPa5iHdGFfBY3IfLs2Yrc1/6OBqBZ34n4ckEeAm
X-Gm-Message-State: AOJu0YwS83/VsHkHOY3ul+9wdo1GX53H6DfQ3AG6+RskHS+GzG7Caz8w
	kfM5hnefWg5kDGB3b/jAl4ntPwnzyyRiDudYMCISvU10XbZ6ZF8YU5XMW20KHvRcCog0pLnsEBh
	cHqMyz+sG7aDQWBVZi9pquXPXVOqeenfUfY/QH/dCFgCCS5ed8musu7/bKPi9j1bpzQ477H5feX
	CTbLjkWYQfhWiqUZRhpBu83TIm1ZAMxUAS0QUZ
X-Received: by 2002:a17:90b:1213:b0:2c4:a974:bc79 with SMTP id 98e67ed59e1d1-2c4dba4cf41mr9455803a91.36.1718589163037;
        Sun, 16 Jun 2024 18:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+QQNT5453eJc8Q6wrY2MwQONVCUdTNKrjoTG9l0wExtAxoW4PcawA6CbvZ6/VnsBDwc00gN9K/+tJsC+cH0k=
X-Received: by 2002:a17:90b:1213:b0:2c4:a974:bc79 with SMTP id
 98e67ed59e1d1-2c4dba4cf41mr9455799a91.36.1718589162769; Sun, 16 Jun 2024
 18:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
In-Reply-To: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:52:31 +0800
Message-ID: <CACGkMEvdL4ieDDbpwy+MGBbHjia5UbbJQfUidh2btG9vPcvWpg@mail.gmail.com>
Subject: Re: [PATCH] vringh: add MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 9:57=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> Fix the allmodconfig 'make w=3D1' issue:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>


