Return-Path: <linux-kernel+bounces-297473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B095B8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C6C1F21E30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA51EB27;
	Thu, 22 Aug 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJqrRP/i"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73B1CB15F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337957; cv=none; b=jpyCW47kPIvYL4a6BaDlH/6xZ9y2FckYGrRfCiedUrTAZccxevjUQaN4nJoarlgOzS/F9zvEGGoPYXqBTOZumavGReZ2S4oUeeu6lJIBUkI601sX411DKUgiOrZzM5YaywbBygY468sqwY8ckbQAfaH+Vo9APIgvVScXn3e4UeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337957; c=relaxed/simple;
	bh=UYliqU8zC6Cy5j0FVRYrcTVg1FwZP3pGPNuhEz8qz/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irWWXTB064U/BaCN/4Z/1ie5m42XIsZxboXwcLTZEss4Q4AsooU5v0NJu4IxuubvR3RBCPNMlV+FT8UrPD+g2lAXSgGOa6gKf1oTYjGndK7iqY7DXjl69CE5hThJkrwQqqj5zRZR6FTB4F+XDMu8rZ6hWfw1gmY02u4cXDAastQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mJqrRP/i; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so88801766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724337953; x=1724942753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqfRiCuHOz5QjE+AHIg341g7rC3lTF4xMoQGWnAZTk4=;
        b=mJqrRP/ilWhIcTA7O/+1TPT3krVbJ8SuineB10Jthbaw3LdV1dEKvcHco7G32NGwpV
         I3QIMA2HQ4d5gpcD1WLpZhlCJvQV05oWNLuxh3i5hj8DS0O7BcawMf+x2hy31QUvRWdE
         UptyPeCYSUZM7YHmDuPXoQyNrU/LOe0Bi5MaW3cLc5zXAXtA0sf5LPcUmkpeMrzttMMl
         HswVbtNdXCCo3JGzTmzG/havxyXDFJRYLBDhdc+0UFGvuf0rbEIpq5QKi4ekwAt8/dum
         DBZtjxomW7ihjD5invJ50fmhAHXDK25oVnaTnDKMNVPTbCSM4GR/Jrfx6hUfDj0YKQJZ
         nXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337953; x=1724942753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqfRiCuHOz5QjE+AHIg341g7rC3lTF4xMoQGWnAZTk4=;
        b=curVoShuHdiaWhWM8znbhN4ELQUF3+6Ajh8UdPTHgzUXOxfolqcE1aZouw5EG9MR92
         CV2W8eJQfePcF91RbBRNyP7r26ajDrAbBDrXV5VbZS/yPv4COD5Kpv7SCv7fk4SKuS30
         nE4mrWBJKhxH+ZWywB5Sr+EZyX28X4bV7QhclUso4QWgrRgKDQgJZuITf8evzV1tjfVS
         8d3istib1Zne02AvTnq9X8U4tXi8+PafVn9gyH8+APCj/84oWrwMzxzUbEQIYDvFdWbL
         gYQZJw/DUUpjeXsmm/cWG+hzRh8KUqvmcELT5OCfebJGE7Ux0x8czOp6IBwP4AMHAt48
         bMbg==
X-Forwarded-Encrypted: i=1; AJvYcCW3K4Rq3t4oSwHKFhX1mf3uANJYIA8JYB8hbtTabj4FRVprrBfbxX0x+UtjVkkzCQEt11oWTNxaikwl3lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYBfwhAj5KykvmxeYJYe4gAbxcKGCljC0Oa+iO/91FskqxW2hZ
	BXeGwREGDOfW8T5d0URj2FfB994qkxf4cgs0loi2Fhzp5+0ldgJOY22XgM1JVyA=
X-Google-Smtp-Source: AGHT+IGTms71ZGwKzmBD3O9q9nvmNcRB0v5c3voGic8zxDJXfFeHvsSYDv7q1ppR3nY92D+zJk3qww==
X-Received: by 2002:a17:907:3daa:b0:a86:8916:b5ef with SMTP id a640c23a62f3a-a868916b8a6mr253254066b.69.1724337953177;
        Thu, 22 Aug 2024 07:45:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f5ae7sm127798266b.219.2024.08.22.07.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:45:52 -0700 (PDT)
Date: Thu, 22 Aug 2024 17:45:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hans Buss <hansbh123@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] staging: rtl8192e: Insert spaces around '|'
Message-ID: <b4b68832-3f5a-4d77-b55d-832bd6caa65b@stanley.mountain>
References: <20240822143837.37768-1-hansbh123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822143837.37768-1-hansbh123@gmail.com>

On Thu, Aug 22, 2024 at 11:36:55AM -0300, Hans Buss wrote:
> From: Hans Buss <hans.buss@mailfence.com>
> 
> Insert spaces around '|' to adhre to Linux kernel coding style.
> 
> CHECK: spaces preferred around that '|' (ctx:VxV)
> 
> Signed-off-by: Hans Buss <hans.buss@mailfence.com>
> 
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


