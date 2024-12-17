Return-Path: <linux-kernel+bounces-449067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFCB9F493D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F83616C6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC1F1E260A;
	Tue, 17 Dec 2024 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N4a5e4Pd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85601E0B7D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432805; cv=none; b=Fe5JuTkz5Wdxg2gJe4tSrCZQWut+094FXBw7HmLmfp+iLDXHtJNzsAzkPG+5E2OUVytGks4Lmlq7TJcaeoSRf02K7fNvSEhtfc6Tyd29gS/GDe42X62/PZI1oj5i4orS76KH/zwfS732iox8u09aR+PxURxkPCT6eDWUAWSYtyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432805; c=relaxed/simple;
	bh=d7+9BW8K4QewUbP2jTwYy/PCXEZT3VNk+0tHz654lX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwgDnufoswscrm5n3c7ywzSORXoohFVQZGbEtxXh1B0xJp5X6DcT2xTtBjBcl1XKkzaixDVi0Rlxq1GivwhdXESraVbaDwTBkxE8hb3O+nQE41FQlY+DWwSgupNkGt3IqFKZMGnb9fPJNcd6ucIM0yQtIbSNee2hKtPL3BVr8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N4a5e4Pd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43635796b48so19886545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734432802; x=1735037602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msWP7diS2kvFRPcBtc78wsxhKDUMb7ACTfsyYyoqYmo=;
        b=N4a5e4PdJGed1xudNG4DA7ccNZNcQLT2whdrcRKF78Go3HzZmBQlhRwTmIzSYnkCpc
         0v68en7gSuuk6mG3vnZENgvtUKBsYEhVqYaPU+lBoLUG7iwbFXxkbc6ll/G/PihZFweq
         SPW865jn0S9TlpfgPtqDLvHYvCICgLoRiyp6zL0bPvHiUSGCfp97A/eNtRCXkgB0HitP
         zs7V9xOD14wvTZO367htj6Btk94W+xy/WhFzsn3v+dWHHbsB2RKhBOAwVyOp4MQHjDvX
         1cjZAvMt0VlbKFhWNUdmFTUktBv2v2wrXqeqELhilVaTNgd2NUrKVjWs4Mz93yr6YQPU
         YDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432802; x=1735037602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msWP7diS2kvFRPcBtc78wsxhKDUMb7ACTfsyYyoqYmo=;
        b=dJTDYMb4FiZC1awciWZZ+YVZue9pLlq5voNpm99Iq9Htd2zXv36vhi83NuvR8C+rDC
         ZF/tBQpmh4D610XP0Jm5c/vASMktkZmW0g6TkwVLkSVGLdmHlJncnKPzcYaW94dFQX+1
         Vm93QStg1dZzZad5KyUh3tbg1dGfyl8R25mq2qj4ER0c4XuaE+lIvSzK//nuC8EdLu1v
         HeuneypiysicrkQIyvrRRO9AzqCXCQtkH35REC+7t9Rn9MVtlx6M3ULFRGTM0wKlT7/1
         i2tTcKdKaPalo0X6QER/i8TBoCPEWhHk9137KuLsoWaRvtHORFPfhUf3RPX+0cfhkLuK
         2/SA==
X-Forwarded-Encrypted: i=1; AJvYcCVxPPZuDSOT/osPoWU77c3LHbEptwJLt+b5hj4hrXdkyBpDx2grkx9N8z8y+5KUt+3m5QFh8e4Hd5Mx7PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZry6zVKE4Prw4Zi3MYiUVJFG35ocqCjmFR3Fm9K9noQJaniV
	ARLOTvB9PEGoVT2VPfYUbnKJGPzGPypIGiQSbkiAlJvzUvOGP+eR/nDR2PTxLFg=
X-Gm-Gg: ASbGncvqF2OGXM69s+v3HRUeHKceX31AEsZ2k8S7dvznS4ph5j5Rp2VezsrSO7KGWF/
	6Q1UhD8bYBKFmuxQlRkpjQz8b+bC4SrXmdCCy+7XalPA94WyMD14RreKYqDp5utXFYQOeBZOt3H
	73QlATAlRo5O9ehwlbiaHd90st4nqVpqvpT9KumR68UcTr/RYaUZJB/0PuRpq90eUwkGNqnbM4n
	YkesICEGBeavMHe1qWupUukdEMUQ7GKOQ8cpY83oY23Pg7cvro1z4QRVEQ=
X-Google-Smtp-Source: AGHT+IGyfrTyYkJoCRxqhYGk1u28o0yTqWD3MD3JzLr8BdSHDbBeflaHknFdAospbyRDDlQjPkcRbg==
X-Received: by 2002:a05:600c:1d25:b0:436:1af3:5b13 with SMTP id 5b1f17b1804b1-436481ebda5mr24912215e9.15.1734432802087;
        Tue, 17 Dec 2024 02:53:22 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80162a6sm10632527f8f.33.2024.12.17.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:53:21 -0800 (PST)
Date: Tue, 17 Dec 2024 11:53:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	roman.gushchin@linux.dev, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] freezer, sched: report the frozen task stat as 'D'
Message-ID: <vyzwumy6fckiwljdtadaqmemevqbz5p4hzc6lqdly5e7v5fner@d2oxcuwzbb3h>
References: <20241217004818.3200515-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2shnbco2dkqsvkjb"
Content-Disposition: inline
In-Reply-To: <20241217004818.3200515-1-chenridong@huaweicloud.com>


--2shnbco2dkqsvkjb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:48:18AM GMT, Chen Ridong <chenridong@huaweicloud=
=2Ecom> wrote:
>  include/linux/sched.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--2shnbco2dkqsvkjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ2FYHQAKCRAt3Wney77B
SUUpAP0cEvTsd+NZqY5PnnJFUIqwjqkYw/teDJADk5wCb/r4LwD/WpK0qoYWJxRT
H7W369kWvcsrqreaxAph545j1+IZSAY=
=vZk0
-----END PGP SIGNATURE-----

--2shnbco2dkqsvkjb--

