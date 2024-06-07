Return-Path: <linux-kernel+bounces-206799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAF900DE8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BD51C2131F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4C15530B;
	Fri,  7 Jun 2024 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWiKj5BL"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21FE13E05F;
	Fri,  7 Jun 2024 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798170; cv=none; b=Q23WP9ku/zGe3raSdWjWrkGmSTVIfe7T9lBjaRkek9dVd/C11R8vs8qB4moNSintgusXyNf8nr4ltvA9h2OmOZcjsSKAgS5uxmwQjTwQiakvrDqhEQSj1oFPtRw1HTKD0Kh5VrMpQ+1bH/2NU53v5hr3IjyaDOBb9qlJ9UdOZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798170; c=relaxed/simple;
	bh=NaIqsQV5khhaGBAWLoEU5vUGfHwgW3Ssi9LjXCgBnvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtpVHnW1iI6lx/91M34YsAIBQ6mPZcy05YQkNdSVFrFiX6Vits1I0rLW0MmtI+wABikozw2ZQURpgpVPzWMvBuLOzVN/FJ1IIu7KEbqCR0YaaARHUB01aCOQN0DtyjoA5NouSXa2nCLFWIcQa9ZNaHEAjdy2d6YZoarVUBk1CRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWiKj5BL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70413de08c7so806731b3a.0;
        Fri, 07 Jun 2024 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717798168; x=1718402968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssaf2eFhFezya16VHLNge+5Vjv9cJhIjY2z41FaXrm8=;
        b=PWiKj5BLCjPDaTQV2f35x2mylEyoj050LlzG8C436/27hkfvdzqZiki9hp2FvqgCJH
         LREVgl2Sqc/NL4MlwCBHjoLvhPZUHzrIfCXVeLI29eTq+TFW1LxtbkZxMLtsAs7LguYS
         Skqw+9eW2p0BP6CpnH4lHIOt/+cPLFXXBKP8VpQl1kAJelQvQE+gY8wjrx5nmwE/OtBM
         8vKBE9Jw2AycQn8LjkdcPS55nYEorpPeqbhVzTrFehv52S0Wf6Kqjm29xwt0wx7WNtmg
         wqgJeXpthmBFOjhj+Ff0U1aIhkXq5qal6hGaGmuFWK/QWjbMFgGv5vjC81iDTjTR1o62
         DrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717798168; x=1718402968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssaf2eFhFezya16VHLNge+5Vjv9cJhIjY2z41FaXrm8=;
        b=fEV8b5BAu8q74ZHlg1BJKs/jjqDhstUFbDbjUx9ID4xx2fLRrUU5B9D0k906TzFZIH
         xhaS3JFKh52SRPz0nCYBGLuqnOPiLN0l3qRrSo88Rlf2vPYnBR0NZMEnYScF7v3ukZN/
         fCEkY4BzSEg8hkO6Xvg+3frWWnD637dqvi/rxgelFu7wUjOdBV8Q6sP5tkRmn8FVXYeS
         0Z9KAxUNrl3w5rcX4BtKU8gm/f/4kalWqzueMI6qsfkf8nRO1H3S5T6HnrM7qjJf45ZN
         ggSYQz/qUs+pFUaeLdzrnAWprTVxLPynFG4hvsPc6m8J3OaMdejxYCwrRaMp0wvSzdFr
         7wIA==
X-Forwarded-Encrypted: i=1; AJvYcCWiwm1olzEY5KF5j48H7dur2eHYnp8yppm/ecswRGfjTEXG+TGeViG2Nu+vb2ioJM3izIwrjeidOM/Ui00MAO3WMiwVOOR8bRSww+TKz4YJyQ7FDoLw49ejR1KDmlu4Nl3zsySzHJap8i0=
X-Gm-Message-State: AOJu0Ywj0QflHWf3ak3WyG9eddmDWrwInNmH8xRZeCxUyAfxE8dj4pl9
	kBvMw56c2HEzRrpiOUyLtCesKPLuLTMubIMA4NUJb05D9HswXfdL
X-Google-Smtp-Source: AGHT+IE3D60iD846Qs1strsLAPZ50t9iiUgvEGK6jJUBN+88yr9Fq9dUKQP9UH3BaX3V6imKC0rkgA==
X-Received: by 2002:a05:6a00:10c3:b0:703:fe0a:c230 with SMTP id d2e1a72fcca58-7040c72e7e4mr4247472b3a.27.1717798168106;
        Fri, 07 Jun 2024 15:09:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70419a36c16sm1100270b3a.175.2024.06.07.15.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:09:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 7 Jun 2024 15:09:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jean Delvare <jdelvare@suse.com>,
	Tim Harvey <tharvey@gateworks.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (gsc-hwmon) use
 device_for_each_child_node_scoped()
Message-ID: <8855b1a5-f1ef-4bb8-af66-2efec060ba87@roeck-us.net>
References: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
 <20240404-hwmon_device_for_each_child_node_scoped-v1-2-53997abde43c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-hwmon_device_for_each_child_node_scoped-v1-2-53997abde43c@gmail.com>

On Thu, Apr 04, 2024 at 01:13:28PM +0200, Javier Carrasco wrote:
> Switch to the _scoped() version introduced in commit 365130fd47af
> ("device property: Introduce device_for_each_child_node_scoped()")
> to remove the need for manual calling of fwnode_handle_put() in the
> paths where the code exits the loop early.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Guenter

