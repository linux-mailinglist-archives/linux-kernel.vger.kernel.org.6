Return-Path: <linux-kernel+bounces-544812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D4CA4E6E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CAD8C4A50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612527D78D;
	Tue,  4 Mar 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FcZrEQom"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1927D764
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103466; cv=none; b=T6nRQlzIdUEd/11m9sYDjjv/GOjzIVkY0UT72BaNkh/4ugiRJ1SB9m+rRQJJP8dLwJtY/7QrvVV/+42/pPfietF26OqFmjKMsb0LN2Vh8RoNBXcptXWKlx4yF8TT6eizNd+VdDxdEQJq6qXD2dQrUUp4V+p2DDc18b+hlIx7uG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103466; c=relaxed/simple;
	bh=k2Y27E8jBe6v83yy6OVDayltip9TmWM0y/2df87N2Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T587XCE4/MY247ftkNx73sXoqP4WXyufhvDJqoc3sYFH2QCDhH+cwKPoscwB1pgChC3wVPlQVacBArmD+LHRugd1KbJ/EdELC2ZssKVN1KQbnlpNI2Md43+iyXMaNEsgdcyeJu7f8D4Y9yPmuGcFuK8P9t2lH1/Srd/0I8M1Q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FcZrEQom; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bcbdf79cdso6426025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741103462; x=1741708262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ztij9sovDefPZ+JmP5z7McxB3M6gtn8pxDpq2Itdo0g=;
        b=FcZrEQom3rzP6z093pcl2f9PYRpfDj2kSxp0utlBlAZ+tepjWwrw6vLG1mTMZ0tgq9
         9hwgdW6biG8yyR7qb3U12rJHyzhi8B4kCb0qU6zLp1pKkiAUv0Kbn1sE5E6CPVNgmML6
         glA0LJoCOSBnPckQtb548POvMBqHomz6SVXJR/xZ/qakb01gQ61mAtGPt5Hs8Vt8vUEx
         VtROY2f/2ZeDhmTwpbvCgc7USsNiBvFQl8doZlLrs0PEKgnGrPJwt7vlBuCJ9cypII6I
         Tjo08yc7D+CKnJ6RnrSwrAxLxi+t6QONXhlL/fLdaH6xOKzOu7BfEgJHKo5SHfwsq+mX
         RYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103462; x=1741708262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ztij9sovDefPZ+JmP5z7McxB3M6gtn8pxDpq2Itdo0g=;
        b=E9zAkMXJKKoaUJbdkwpEkC2/iDjPAy82377kahcZj4SZZWMaVbDc8uRgXSGDZuGjza
         Ua+VOAdGRo0JC5nvOBjhAet9TxybLUp40/0HXoGC/hIMi0xLvaexuntCkcrelqNQ8YbC
         WSRx4C1mHraJEePfWrZcoE0ovQC5Xl9r8S3zsk+Lg30d+OoILjmtETmaWb77mtrf2SVG
         Fjh+n4/6/wy4emzktD10eK5ujKTgkmZ1sOL//Xc2bRXvo43mpiRqkbOhkiRppbwKsFhd
         E2W9p8otHWjNh8sQf6aKf7d9LKcrc5o4CNA7EsmAu6qiO9slFS0KH0n8vibx0VvSjmKV
         znow==
X-Forwarded-Encrypted: i=1; AJvYcCWh2aRl+5gbnUkfYLt+GsGdG1SS6hjVirAKD0TEYLpDVUonDfaETcEC8bIUp3wcksgMDREfAQFVY/4yTwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu74brRnejnPn2rF6nrRIpxqnD3kAUoEnQsYkBi4N4xahnnBAY
	psyK4b50GaTQdA6kX4H9m8x9MWOnhgWMdG2T6nOQjxm7ktQ7/Qk38OpWMtThGzY=
X-Gm-Gg: ASbGncswEe0xU0kRVsV0uikQo8DhehhmNx1h2MDVlzMsHF5Q7udI/z61AhCNxqtMYtK
	ckQFTM92bDXidv78JOyj7jZvh/xZcvavGIv13TUPAn/DMkMmt2ASX0dw3D0YdiYYUDhHphscMks
	awfYlGeZcyRj/lk+qa9kAqqsshmnzxQJwyxLqqKObvhu/CTq/ieuLE0SYohgFghAWf7N2wEY+cA
	iZz+fsLCk+CeY4+71jzRJk7UBCvj7/8771nXBTh/mq9f+xWLf0QuuKhXE92zYs/dWC47yf/zWXB
	BzTowIRF0585YQSLFFBtQQgCU0hAQdChKg==
X-Google-Smtp-Source: AGHT+IEqw732r+HZ4NWu3JQYHrodjvDxnDB1NIugP9b50YqhrS6dPwVXDZpklzhnZ/WuAjHzoYGFCA==
X-Received: by 2002:a05:6000:418a:b0:38f:32a7:b6f3 with SMTP id ffacd0b85a97d-390eca41867mr11311863f8f.40.1741103462172;
        Tue, 04 Mar 2025 07:51:02 -0800 (PST)
Received: from pathway ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bb767a977sm99979765e9.18.2025.03.04.07.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:51:01 -0800 (PST)
Date: Tue, 4 Mar 2025 16:51:00 +0100
From: Petr Mladek <pmladek@suse.com>
To: Vincenzo MEZZELA <vincenzo.mezzela@suse.com>
Cc: live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, joe.lawrence@redhat.com, corbet@lwn.net
Subject: Re: [PATCH v2] docs: livepatch: move text out of code block
Message-ID: <Z8chZIpQkrp1GZhy@pathway>
References: <20250227163929.141053-1-vincenzo.mezzela@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227163929.141053-1-vincenzo.mezzela@suse.com>

On Thu 2025-02-27 17:39:29, Vincenzo MEZZELA wrote:
> Part of the documentation text is included in the readelf output code
> block. Hence, split the code block and move the affected text outside.
> 
> Signed-off-by: Vincenzo MEZZELA <vincenzo.mezzela@suse.com>

JFYI, the patch has been comitted into livepatching.git,
branch for-6.15/trivial.

Best Regards,
Petr

