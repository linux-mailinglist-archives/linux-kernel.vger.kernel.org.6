Return-Path: <linux-kernel+bounces-298511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF295C83F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85B7283166
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF6149C7C;
	Fri, 23 Aug 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pgQv9t36"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E67346D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402418; cv=none; b=XLQrFaP+mkjmuvq8bL2cBFnfwUApp1fLtmB6XXs/rNtoiXH1JDUE5exs+dqeyBef0OD3p9jC/zvRybih2ByiPuxqxhRWjW86v/OG1nGwL44qjjTFb/9Sw+KQFbDOYoXgGl//pWcOGaDVl7bHfvB0eM5QTZILgWr6CS7LG3fSREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402418; c=relaxed/simple;
	bh=/gkKdkn1kch9YHgvbfB4pJh7hu8uTpCucVk4jPgCW2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5XG3fsEJ7b1C+fyWQqWZlFuOYAJBX5SkBhpzhYKVJQjxgxd+xA3Qm162ntqRtPHIhPVjkJatIElp5GfQhBErTJe17YRd1X1Lk8Nm3IFidHN7ZN1od3rZ6lVU/nr/ah2ycaZbxQGTabSaRXrudltEmpOzMXxoTtTz/Dhl+uNo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pgQv9t36; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8696e9bd24so161166866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724402415; x=1725007215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gkKdkn1kch9YHgvbfB4pJh7hu8uTpCucVk4jPgCW2M=;
        b=pgQv9t36FhrDOoXSd3BMXJ756sNDTzu3RHAkuG+hrV4EQCc9z5mglilHHvBzDHRvf1
         Q3oiN8RIWYuSmS6w+Ji/ntWe6AYVlWHU+oM5z2rOWixjV/1PhylKbD7eSwU1acbfxtuJ
         SHLsaNYUqe46Id/A4TLcKp8gpL9ET6Kg08NzFs0o8jDQzTd4zU/fIjdiOWG0G2Fapi+b
         q59NnLQEYbKCLCjoHmN8HU/lLRXUg9ckjdqW5Gx0ZPhJkYAQXcRwJfQyh0C136TyLu70
         6XbsA21pe5aLWcrOdm+C74skr9bu1gz61ro1ypkYhqyiBvlJq8+lxOXv+GktIMOwExDd
         6b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402415; x=1725007215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gkKdkn1kch9YHgvbfB4pJh7hu8uTpCucVk4jPgCW2M=;
        b=MjHh+8WW8C1Jwul/jBmIbJtb85hUGFmvW2C7GSCQ0Wj0r8BOn5E8g2/cZXKyO/sTFx
         joIm20Yt84oBM64FQw0VISplZZb4LI+jM4XPfsck79zXACv71vi6LFSai6anUVekBuyH
         KHcJSDE9hAHLIecmC47rboEUXScjA2hIRlOilg7U/GSs5iBFUD5aXDolAApehcGrBt1Z
         ooniOMQYFK/hliaU9Oi4upIB2xT35emebtD0/AyFEKb+5CYrPpOLgdGdWFXM65NIvHXJ
         PStcofvnLkJkmWThtxDE6N6+6zUxv7C4cbQIyF0giWCB75w2WsoOt6ukwtbSwG6lLtER
         GD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy6bQH/cbvn+j7YBH/2WvEyxYAXNxYYGYv1dBTVZ1OQCKl7jf5HjF513japbtjaNL+zwZdXoqoQs4doXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitQNkpU+5KAWMq1J3t0KCTYYX5XTeFar4HoMVFrd5mH3WNilV
	LRN5uv0pNWjyzmfwWk9wTBJj8DqnLmt9pUdBNU2TWl79RAc+/Q6Un9Sy158mehM=
X-Google-Smtp-Source: AGHT+IGaPZGfsEcdpD0z2HooWb5CW/e+RVLq6gXdB73IpyHPSTkCKbWsNG2C5VF/YTe9NZwWRUVqtg==
X-Received: by 2002:a17:907:7e95:b0:a86:668d:c0b2 with SMTP id a640c23a62f3a-a86a5189298mr133154366b.7.1724402414734;
        Fri, 23 Aug 2024 01:40:14 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220324sm229420666b.44.2024.08.23.01.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:40:14 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:40:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 2/2] ice: add callbacks for Embedded SYNC
 enablement on dpll pins
Message-ID: <ZshK7RwzHO_vZtdN@nanopsycho.orion>
References: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
 <20240822222513.255179-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822222513.255179-3-arkadiusz.kubalewski@intel.com>

Fri, Aug 23, 2024 at 12:25:13AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Allow the user to get and set configuration of Embedded SYNC feature
>on the ice driver dpll pins.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

