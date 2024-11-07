Return-Path: <linux-kernel+bounces-400459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402DC9C0DEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050AF284BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4E217310;
	Thu,  7 Nov 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LE6J9HCj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A8216A2F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004685; cv=none; b=D6BvDpqjcJcq/0EnMT+T4JLKWQKQ6+uGYbGOt0DkU17gL2v91ER+x4eekb9DgWGC3f1VauRHvST6YNTrhVywq513fgXgN3t7FvzVnj3s7LzQOt2+RXB1oxPZaCMyGZ2Z9k9sTnN38t4FcLJ6JPQKfesEftTfsWYDuTxA6mECfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004685; c=relaxed/simple;
	bh=j4z+Fns8x9ZZVL7xS5DhZmq8fKl1pJ7ijpiGLozCkeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhvYcut3q4ZHr/cG8khdw/kBQHDHEBAqRzb7zLa+5HAJzDxR21UAVK99T+k/W6WXLWVstAvNgeXf7ewSdWeVu2EGeOF7y7Wvai2Dk4QziMuKDzdrc1sydM9lFzmFhorEYhIGSS8PojRC58Y8tkXfks3j3HY1T4nTIgvqdU6SbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LE6J9HCj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e467c3996so1039063b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731004682; x=1731609482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nx6djZ5SW0rcyyK+GjNT99EYEl5ledvAgIxQlMh88k=;
        b=LE6J9HCjGqgHMMMvvo5aTblD2kOKBVuRYysJMvxtdrnt6kL+UHaxr81YrYzqMjChpB
         8xapE8rXsz2FVP48aQtu6bN4k68feZUGKOR/6WnPy1CfmkgSZat0gwapjr0nabIdDTzv
         cbwmOgUutnzIC8RnvMLdsY2YQ6d5N5IxXQMgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004682; x=1731609482;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nx6djZ5SW0rcyyK+GjNT99EYEl5ledvAgIxQlMh88k=;
        b=KI7FjTMlpp0XsbGsR4BvUjZz0YwM/4hjeVZDA6ag20OiqK3uriu5vdfjyTgVMYWKcl
         K7bJ0ORXiLXVb8c5yAawCzre/gbIaezGy/kTTcHu6bG97c1cAbZXVY1XTszb1Nccaivb
         UWH9UY21WPVMnl22Q7L0DRRTH7zCOWxZuEsxkyKmKi3KTwgN6GEltcpIXitZXxtexxpq
         fHcXwUOhdo2c/jgcqrlHIWG2f4PYRflaMHWRvY9bcqifIuGD45wkE28vVe4yzcQ1ae5T
         sdcgX/nrREC5xPmIDREuv7sdiL7c/bwxoE7o2OVJ82yX0KNw2r0SE992XfkMczTn3If4
         p0gA==
X-Forwarded-Encrypted: i=1; AJvYcCWHiGyAamb5Ohuu4WCKuTHowCw66slhaZATfZISUjxU2GMNIvG6z0nxzPRqQNYmBDh69ogyNQI6zh4isD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Az0E7oQ3R40daYKDdII99E5L9G59FuKsvbq1L4Ny+NCczgZV
	niUU/X1PY+ZbfrUnjPlyqk/Bl87k9wHxktz0Z3r79PLitpWCWCaS3TXOkrX/vHM=
X-Google-Smtp-Source: AGHT+IHhHxSSqRq54/0JItZrfLUArZzwi5lhSJ/n5p0OufOKDk5pu//5I6H8GvaQnvaUGwoH8n2MsA==
X-Received: by 2002:a05:6a00:c96:b0:71e:3b8:666f with SMTP id d2e1a72fcca58-724132cc143mr119723b3a.11.1731004682204;
        Thu, 07 Nov 2024 10:38:02 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ab561sm1918711b3a.71.2024.11.07.10.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:38:01 -0800 (PST)
Date: Thu, 7 Nov 2024 10:37:59 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v8 12/12] selftests: ncdevmem: Add automated test
Message-ID: <Zy0JB3UxBIm1FZa6@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241107181211.3934153-1-sdf@fomichev.me>
 <20241107181211.3934153-13-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107181211.3934153-13-sdf@fomichev.me>

On Thu, Nov 07, 2024 at 10:12:11AM -0800, Stanislav Fomichev wrote:
> Only RX side for now and small message to test the setup.
> In the future, we can extend it to TX side and to testing
> both sides with a couple of megs of data.
> 
>   make \
>   	-C tools/testing/selftests \
>   	TARGETS="drivers/hw/net" \
>   	install INSTALL_PATH=~/tmp/ksft
> 
>   scp ~/tmp/ksft ${HOST}:
>   scp ~/tmp/ksft ${PEER}:
> 
>   cfg+="NETIF=${DEV}\n"
>   cfg+="LOCAL_V6=${HOST_IP}\n"
>   cfg+="REMOTE_V6=${PEER_IP}\n"
>   cfg+="REMOTE_TYPE=ssh\n"
>   cfg+="REMOTE_ARGS=root@${PEER}\n"
> 
>   echo -e "$cfg" | ssh root@${HOST} "cat > ksft/drivers/net/net.config"
>   ssh root@${HOST} "cd ksft && ./run_kselftest.sh -t drivers/net:devmem.py"
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/devmem.py        | 45 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py

I'm not a python expert, but the changes make sense to me.

Reviewed-by: Joe Damato <jdamato@fastly.com>

