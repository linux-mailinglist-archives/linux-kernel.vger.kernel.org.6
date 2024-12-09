Return-Path: <linux-kernel+bounces-437044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12589E8E61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EB52813A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB421505F;
	Mon,  9 Dec 2024 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcjA9f6k"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE11EB3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735319; cv=none; b=GUe20e5elDy6KSmK3RxzYhBq6glz9bV2jyH+1ixPKE6uF3ZDfdzKZ10td6/pTIbD1zDDwz8/tRy5UfZcfCeRWNtwo1/9vKKtLrNOhwxXa8keLOWqvc5G7fQPUTKYQQVjgMu7p3pzr/hrVeIQ/k1nwSzEBrGYfZ1Wv9Es+i0TyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735319; c=relaxed/simple;
	bh=RGRaiSPrJ4Fjoa4wWn+D2mUhO0ZTQN9y2c6gK5ph/fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3zaYJM4nik66WRQwfHPkJd3S9HcHpo2pB5D6t8z2z6vjZGduRzu4rXi8OCd6Ux78Z6aLj3F19UBFYC2FiydmYHo+zH0wy7VOP/MJpPgUEZgYYNiH6JdQRogvK6Lr18kaneApEBNTxt8dGjXEN3gAb+1yQa7g7k3gJ5BtMHB/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tcjA9f6k; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434f74e59c7so7743545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733735315; x=1734340115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsJTx3PH9goQcoDcessIJUZiUDgu6MKdF7cPS5GqSak=;
        b=tcjA9f6kwInDP3FLGN06DadU7THfIQsS3+rKqUwx21Ze3+wWLIEgv5Ye+DRdQVeZkv
         Uwb+Re8uKixr9t1TdJCYDaufBDXwzjg937JRqDSXM2BjshO/vtE38XE/S5H0wsh7nZpX
         yGRphAwGMuGUNBhOXUnmBPx0tYi+SRa/Ea3WBH5hAy1GS4hsaWrEJn8lELn2pPvhnQCA
         ZG2CG90Wj7KhpYAQFMGgLD2obf619KktHivkPbDD4udGV7VOjsMaryPA6kt5JmPV8n0u
         fwan5JXIP8/TtBvkRtuiPwJk3V1Q/cawX1k65tDqm1r3pDXfWiqOf4Ind4himJFERNvi
         3MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733735315; x=1734340115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsJTx3PH9goQcoDcessIJUZiUDgu6MKdF7cPS5GqSak=;
        b=xLwrGiu6JTBhLm+hw54dqyR9tldAtS2S90bxr4LnP1Eud/OZfb5F7cdKzxgmd3swpV
         /3wOqBzU5eY3reml163nplaI1wteat7q+1pvx7EZliq4YR4uAx1LpgVftYcduhMXLP36
         6CdWXxKp3gzSMY1ZYz4A5knLEMkcLiAxMEpCeBSJ8vSuO0CM6Ardfw64oVOn2IPwWUbP
         ANSFf5f001FoQpHoThof6fmWs4j+3KP4Z6mi3Rs+UizzAMe62ORgHslCts9+SJ1K2Vha
         G5GfjGAmyiLAfSvCDbUSVk4PqDMnguUZerO4fgcRUYxdHJ0DrYuG/p7Ep4m0RqcBeHb3
         De+g==
X-Forwarded-Encrypted: i=1; AJvYcCUXjlKafImeT4GtbVXyFCCGfGHWsccQdKbVyQvXBGphTjimsB4FyjBpzJXG13msuckxQxLogcYlo9zHMY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdyvrRgq7r4HON++niw57RFidoaf5rrYS+him9Nc7/EB0uGK7
	UGTVsFaOQwfLf/JhADOOfupvKH0C09+SygLiFxySptwBckNDebS4RQ1nNZMeAd0=
X-Gm-Gg: ASbGnctcNel4hy+duKLLi2ERdUHKLWeT08l5E+ZPq/ot6IuUx28XySBv68HYnDtUT0z
	THjnt3k6Phodf5qiyZ8qtH3zh6GM4OKVD3ovu8m9RKoj8p/+Y8055LjPUJrKU4IFsaZQ6vWIGQj
	GCSESM5DN4sXZEsisnEvkm6t1Fat9C4WfAAGd3RckL1pRgS/qhUNtSyEvdsrTUCH5/64HUEHADG
	lsVUfuBEDfrbcmud33JgaAqkNCZgNpxnsHWq71Iw8zh2/XiD+gE8Zk=
X-Google-Smtp-Source: AGHT+IHwHqNdsCzlg9RIis7WzBaAxcQt1cpiTsM/IaFi643v+MgHZjlMz6/EDDZGZNLcoK/eGnRCDg==
X-Received: by 2002:a05:600c:1f91:b0:434:a26c:8291 with SMTP id 5b1f17b1804b1-434dded8240mr96456195e9.24.1733735315514;
        Mon, 09 Dec 2024 01:08:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4087sm12827984f8f.5.2024.12.09.01.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:08:34 -0800 (PST)
Date: Mon, 9 Dec 2024 12:08:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Dave Penkler <dpenkler@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: drivers/staging/gpib/common/gpib_os.c:871 ibioctl() warn:
 inconsistent returns '&board->big_gpib_mutex'.
Message-ID: <d19c29ac-a084-4feb-a272-5ae6361732db@stanley.mountain>
References: <869e62e1-cdcb-47b3-8092-2d5c203ecf1a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869e62e1-cdcb-47b3-8092-2d5c203ecf1a@stanley.mountain>

On Mon, Dec 09, 2024 at 09:50:15AM +0300, Dan Carpenter wrote:
> 9dde4559e93955 Dave Penkler 2024-09-18  757  	switch (cmd) {
> 9dde4559e93955 Dave Penkler 2024-09-18  758  	case IBEVENT:
> 9dde4559e93955 Dave Penkler 2024-09-18  759  		retval = event_ioctl(board, arg);
> 9dde4559e93955 Dave Penkler 2024-09-18  760  		goto done;
> 9dde4559e93955 Dave Penkler 2024-09-18  761  	case IBCLOSEDEV:
> 9dde4559e93955 Dave Penkler 2024-09-18  762  		retval = close_dev_ioctl(filep, board, arg);
> 9dde4559e93955 Dave Penkler 2024-09-18  763  		goto done;
> 9dde4559e93955 Dave Penkler 2024-09-18  764  	case IBOPENDEV:
> 9dde4559e93955 Dave Penkler 2024-09-18  765  		retval = open_dev_ioctl(filep, board, arg);
> 9dde4559e93955 Dave Penkler 2024-09-18  766  		goto done;
> 9dde4559e93955 Dave Penkler 2024-09-18  767  	case IBSPOLL_BYTES:
> 9dde4559e93955 Dave Penkler 2024-09-18  768  		retval = status_bytes_ioctl(board, arg);
> 9dde4559e93955 Dave Penkler 2024-09-18  769  		goto done;
> 9dde4559e93955 Dave Penkler 2024-09-18  770  	case IBWAIT:
> 9dde4559e93955 Dave Penkler 2024-09-18  771  		retval = wait_ioctl(file_priv, board, arg);
> 9dde4559e93955 Dave Penkler 2024-09-18  772  		if (retval == -ERESTARTSYS)
> 9dde4559e93955 Dave Penkler 2024-09-18  773  			return retval;
> 
> mutex_unlock(&board->big_gpib_mutex) before returning.
> 

Sorry, this is a false positive.  The kbuild-bot can't use cross function
analysis because it doesn't scale.  But if you had cross function analysis
enabled then it wouldn't have printed this false positive.

regards,
dan carpenter


