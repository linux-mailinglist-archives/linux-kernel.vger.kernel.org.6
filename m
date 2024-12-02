Return-Path: <linux-kernel+bounces-427394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7449E007D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E339164341
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17097205ABE;
	Mon,  2 Dec 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b+NmZeWJ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE02040A4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138360; cv=none; b=I+GaTIkZOZ6zKrbt3+RlfFbjqxia62iyQ1RUKF0BzVA3gUtrHr82oi1e5G6umrkeI3FYKCDkfd/RoQPe5V1djuuxA+4QOn0XNjwCaWMMMxknicl+HQrvzrqsMxsXMb1rQDBxRzIJZNb8zIND81qnu7sF/25OD4v8dPQHt7/De4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138360; c=relaxed/simple;
	bh=UDkly40TtE5zs/2psbTPPKDXYILvvesF9HODlMII3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCTpAsUIXMXHFbovp7X80nnEwFF46/G+Yyz4lnlwwQ28j5kgDcm2wx01flRay6GgKyDjMv2Nt3mZtt/jIrbap8/ZZKlvKuXrTbUpta98J0q/h19q0i0J+8X3VXlc0JvkcUfJaX9O3YeJdcriA/RVlTGc9vEcUej89KuZMMF92lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b+NmZeWJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa52bb7beceso479557666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733138353; x=1733743153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcn7h2SUgJyhRfUcV2fZ7t39o8oNaSoR0j4YwtA48gc=;
        b=b+NmZeWJ80J70T8y3jZ4dPUKndHCBAwHUku7qdVbkndxpre1isl9mMwwiurqu2HJ/1
         ti4OcHhbSiElL34Y6gh68GFpfjaN4VukUP7SSwzQiIMTUVHB80/Fly8gSzUXNyOd9OLN
         ML2SXiyhTwP882GqXZkT0cHP/G/FNMMjcKiC+WTYp9ZUDk9QTu0n+viQ8NV9tglHjp5R
         7PpgLUe1lgypXmZWCwEQYwpMxeyLAxYGTfzhurciFFPlAqw0qq5dSt0Idz2okqyoxn0s
         eyiqvRD4zaIps3PGOr03Ie/IZ1q4xmSOfetm7S8htilYeS5TSfMfCcain6E+Mu7o7V+Q
         j31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733138353; x=1733743153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcn7h2SUgJyhRfUcV2fZ7t39o8oNaSoR0j4YwtA48gc=;
        b=ac58LmzpP3uGgaYWU7uhdXISKHUqCeP/WDkueIeXdNx4f2GmeRr07vte2O24+FENMD
         0bJCqFG+BX4g5wfg2TO6lHr/fyYLm64lx9LWNtMLnPk4cmrnxcGR4HbRRNugXQdK+1Qu
         iJBrXqQ/m89WmpevwC/rk43xAEgi9N4YPG+PlhRYqJHoa3DiigtjaFS1cTh3Oa+pXq7n
         Mq4PhuFIhb2rIyjMeVyrRrav7Du0ViALZv4CStsoxorkx7X8osNM+5Eqg8lj/kgMpnqK
         g1CsVfnLKXu/BHOjKYgVd4Lz50eChxgDEsTs6N94eCbsMF7WCAMiuPO7ChSWL55bHZlD
         8eXA==
X-Forwarded-Encrypted: i=1; AJvYcCVwjdpAiP2mIQnps59v5W3E7A70qwIuef+7DYBj5MIS3OV3ww1k7mtc7ZpWBNTNt4T9FvZDusfWau9W1AA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4slWcrE5Af3VXJm61ibrGZ8auMgW41kZyF0IityUdz0SzIHd0
	xgppCN5v6mbsOdQNvVvVoejtcq4VB+zeZY5Lx7sE2Tq7Dc8QIuQyudqKDJ7UOjY=
X-Gm-Gg: ASbGncsND1h1vK48Obg7DINPwC9k9xfXlaek3nsAfLkdTZ5KxYuhZ8IKvP1Z2Es5+kj
	K//vQZ30z1TPeXWm3Tv6mQqQctnUKZTd6u74UOarpLaOrg9VGMAs/jD33pec51YHokDh3+aNvhY
	9jmfGVAEOSx1iJNnM4aEU/qHDs+rbgGBsV/7aDfbjjF6uJo+0jjBqYzPnwcwY3pNMMSMFNZA2Ts
	rnsDhevfTFsFAYpHDim5ph165Y/rToquT6Q6LPhnY7SmovbtvU=
X-Google-Smtp-Source: AGHT+IGrHk2TNn8u7iJFAgIJqEDQIqqsYlNpumxpV+QMRsW0RtgficviCeiMEXouIkFntsVJygDGQA==
X-Received: by 2002:a17:906:30d7:b0:aa5:b639:e2f0 with SMTP id a640c23a62f3a-aa5b639e8b1mr867113966b.35.1733138353674;
        Mon, 02 Dec 2024 03:19:13 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59991f215sm496596466b.158.2024.12.02.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:19:13 -0800 (PST)
Date: Mon, 2 Dec 2024 12:19:10 +0100
From: Petr Mladek <pmladek@suse.com>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] selftests: livepatch: add test cases of stack_order
 sysfs interface
Message-ID: <Z02Xrol9cOCCZdde@pathway.suse.cz>
References: <20241024083530.58775-1-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024083530.58775-1-zhangwarden@gmail.com>

On Thu 2024-10-24 16:35:30, Wardenjohn wrote:
> Add selftest test cases to sysfs attribute 'stack_order'.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Wardenjohn <zhangwarden@gmail.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

