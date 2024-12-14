Return-Path: <linux-kernel+bounces-446075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E19F1F96
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027A77A06E6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFC196DB1;
	Sat, 14 Dec 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P825Ir0b"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4918BC1D;
	Sat, 14 Dec 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189125; cv=none; b=Ds/FYWL1tFQas3NLtrQ0zYXLi620W6q+x+zJX9/0kKRN3Sa2jo94l642JOrn+vE7j/F32YITcrP0D5oOgIzg62MmAEaUjuYJI269ZFeJGP82SZFg4WjiQsLAe3vod/+NI9lq32EdljSzhbhVooAbK+8ipkVVuT2QBO09qLz68J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189125; c=relaxed/simple;
	bh=CuihegCetP2wfXBh+GgH8wCcWkpri8WuSu5R8isN6pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4LaQ1IA0x0ZGeXpQVQXZusA1JKvPW0wCh369whO/pXeEhr6VMIl2j19jPlj7+Indr9WWpk2AyDBO26DcybbIKyBEERV20C6lbHkD/3JSPRonR8R0kV7+lWhxDLzeGByLZHho0Wt59Bk93BVsoZ8V+MP3cwsEDbaViF4ukNnXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P825Ir0b; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728eccf836bso2359161b3a.1;
        Sat, 14 Dec 2024 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734189123; x=1734793923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBnGHcbvsr9vY569ODSEr2yMGTsezdkq5pbSt8hzCg4=;
        b=P825Ir0bkMLiLttNUMQOlTEMZQFc/jSVMvaJi40mJsrkQeuwMgA5Y9yDyxjuWK92HN
         JPdDMpJaRNV8ayMNuMUToSsphz8gzVwY9gr7yWtP2/O9/HSHMuyrUcQjqb2z3eD1db7y
         NjLnbEjAn/dkXj2JBCL924tmHZMd9GQh0Y+uqnpEymb7nuU/YWI2pjGo27UNDBCjhFP/
         VAaO9LxeiNyj+uPfi3dvK5531xnR/n6V5of1QQs7fMnDGl0o2HZ2NJ2XDaVbEtJ5B0qS
         JXA5J8JIjnahWmQ5P7EwuncHfqpIbAviOjsZusPtkdHzwkVyaQgfU6d8nZoa3sP3DHt5
         AYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734189123; x=1734793923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBnGHcbvsr9vY569ODSEr2yMGTsezdkq5pbSt8hzCg4=;
        b=aua7hdBRmhhQyE8ZzdJeb3542y9WmochDJiDM0mRD48j4Gsgv3/Puac4L23U+rzaji
         rTYCAnoZzGXU6tr486zlcV4xPYk8buzToxDv/YA+NSOYlZJJYVpL/MhXIeMnfM3Noxsx
         j+CJ25PRgAM3IW/bwjDtPMyeWiE5VsAmvrrjxK8ZOIufDXBtpnIgLCA4uPfukvpJcPvp
         bmiRwLmRaC6ik/13GMDcfUh5Y952VgL1gI/C9zgBYN63UxxOIYb2W5P7r0wUtRyOmYCn
         zPO5FXCqdmwNg/060rT/H5Lpbu+MJdjKrBE2VlufDMuBU6sGHAu4/z+BfULGhmZ8mM85
         1Kyw==
X-Forwarded-Encrypted: i=1; AJvYcCVDqDQd4MR6SXvFmRORjUa1076+Lz7+Bwal3r8/GLSgsIUkemtMJzOT1DdGnZOn5PJe/GViVgYgM6ONMHZ1@vger.kernel.org, AJvYcCWe7J5LVgeUs+WbQESplxBk4n2UugBPlIckBhJdrOHIn7oK5Dx94z5EKFx+WMJnAL0fG0k6wrRoM7Chxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGpE3n3oGkK8/6896KvaD+Uu2rNVlcqs/tOrI8bdR6/M/FCcl
	vxmAHBAXwnpajQb1QahLtx9867hxFFPzNkYumsV5OD4YUMCU81tA/ihy2g==
X-Gm-Gg: ASbGncsLKwHNjMoJAMHOWpIvIpjNqkrQmqnpLDMvHu7aBFgJRXPztR+xbLIqap0011g
	P+cCDX3/pxtTTnMEkX5J8VSbP9WPG71pnyJ8O4D07StuPGj6gUvxWT3bPo+wiQfe8s3Vuz7MKNQ
	QznJRgYASUpngb30j5iC/4yH22tTp0sBF8pLP2j5Qf+7HTNS99LSkCb7JBcr7peD4M7zsNH0MqM
	kXVMOcu/ZFq3AVwrH80COD9W1nLLj9+NLu/yLEK5TgrkRywvHwnR7ebJiSx/1ETV88b1A==
X-Google-Smtp-Source: AGHT+IFp4NctrZXEabka/02Mv+6VSdCrDzIaIIVfMwyKrKoenK0HetRm+LEaAb918aNwn5Akgboesw==
X-Received: by 2002:a05:6a21:3287:b0:1e0:da90:5f1f with SMTP id adf61e73a8af0-1e1dfd58f6emr10336531637.16.1734189123597;
        Sat, 14 Dec 2024 07:12:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142de3473sm4919117a91.24.2024.12.14.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 07:12:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 14 Dec 2024 07:12:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Max Ammann <max@maxammann.org>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6683) Add customer ID for ASRock B650 Steel
 Legend WiFi
Message-ID: <a27654c7-c017-435a-aa60-ab9ccd27cb15@roeck-us.net>
References: <20241214102201.122851-1-max@maxammann.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214102201.122851-1-max@maxammann.org>

On Sat, Dec 14, 2024 at 11:22:01AM +0100, Max Ammann wrote:
> This value was found on an ASRock B650 Steel Legend WiFi with an
> NCT6686D chip.
> 
> Signed-off-by: Max Ammann <max@maxammann.org>

Applied.

Thanks,
Guenter

