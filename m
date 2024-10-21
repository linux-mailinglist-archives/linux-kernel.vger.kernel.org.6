Return-Path: <linux-kernel+bounces-374973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9229A72AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70384B21480
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1BF1FB3D7;
	Mon, 21 Oct 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9XtjbD9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58141FAC31
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536950; cv=none; b=hLlXCrRJxcjrn1tc/IzKcYHk4dKWh/oABTtQnl89aHasaOU+p2isEDs+G0DeANw+4ioWt2DJaO9bRoXl0it+Oa2r7li046bbApaCu7TWSqcWX0GzkG2tVcFruU3lfC303SguzqXQHXPrpvkb6KeAmXHArCm2bCrmMdwFFIOjUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536950; c=relaxed/simple;
	bh=P94yeCZ1yUprg6wEzxiZ9AkuF/1MTkg1vdVbCLsHZ0k=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=RaMqDO4HZJf8zoa+iAN052PJrLh17E1uz5FZU9b1+Vg6jfbDlBLJuHbvXFtKWPjCtApffa6u+7o+NAynDerET5KP4GmH0to8y0E1d//Hou/SuX+G/XD55YlswCcLKnPuWFHXooeG95zhk1b9qDyqJMIc4d2WmDDiZeul1N9i1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9XtjbD9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729536947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBkJ6hUVM4B8eeUJkxTpyoBu12NtgYMeTdK6LmP0Sx4=;
	b=W9XtjbD9exqR3KcIhmofS3gSobCPBoLQ/rBjOk7kj4lTB6YDk4MD7znupBCuz7HmdNdUaP
	tBsYGiio8nEdGH94BHnqZzQdeHbUAycYMl4l+9WVn+8gMdekRufV/JCTlaH7GaBwFu510i
	E14bauvJmpLQM0xbAXUx0gP/QNUt7+c=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-V6wUKwbBNCGSW9O3q9Oieg-1; Mon, 21 Oct 2024 14:55:46 -0400
X-MC-Unique: V6wUKwbBNCGSW9O3q9Oieg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-84937f5859bso691198241.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729536945; x=1730141745;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBkJ6hUVM4B8eeUJkxTpyoBu12NtgYMeTdK6LmP0Sx4=;
        b=MP5LI0nvQD+mtpg/VaGo0Jyp4iN3h7DlMiz6KZGHvnGW6XQwAzcjC5zAVawkidUdi3
         LlOlFBAdnClYrnNTQtiPs17WJSdcZBWtMxZZ9tuFgvwayuAD3mXPLvK/q+rZ9M3hGZOo
         ddISsCOUzwoqLYv1XeJjgqsUn2MT4CawBFACn3MbIvFQmibwi5PXeUWeFWeRoePVAEkN
         7T7be+kyM5kt7QhTY5iCwF6x60y8HEqwaV1kl4Zlr3fdQLSdWGzEb3KwjbU1DZ56fhVr
         mF0EDARyc96pyn44XoE0AB+9Azw0F+o/IVQBtPxfI9laVLZxSgHTY7IpSHsrNYKHlC1S
         egQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/+Kd51TdvZPd4pWz+ObwWHvD0fXDZRDsBkrcToR2Gctvn2ZIIsQHsKfZejH1X3FfFEzcPLij1HG8hvVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOj7GONeaCkiNpIzzZrxqRPY3h9g9GWVvmCFVL4+Y/J/eSkye
	YdtCuPoTsMMHqdgRmmiVF7gvwhIFM6VnzL/NHKxZY/mOL1glsxx6JFGFtMMom+5tOnaYp5l4XV1
	RxqV/+at6cTXrBgV4+RBQvFJPpQ3PwORJlPZB+18LsOZxhqpcD+NDnHXqUKnobw==
X-Received: by 2002:a05:6102:38cb:b0:4a3:c516:3173 with SMTP id ada2fe7eead31-4a5d6ae510bmr9645984137.12.1729536945685;
        Mon, 21 Oct 2024 11:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFidBydUUsOgzIfYFVhv13IqsAmtwVFb+t47/0xhYXC+BA6NbCa2gpPvYQ9JU6flUBkSbmWjA==
X-Received: by 2002:a05:6102:38cb:b0:4a3:c516:3173 with SMTP id ada2fe7eead31-4a5d6ae510bmr9645967137.12.1729536945375;
        Mon, 21 Oct 2024 11:55:45 -0700 (PDT)
Received: from [192.168.1.18] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c6398bsm20764881cf.30.2024.10.21.11.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:55:44 -0700 (PDT)
Message-ID: <da00cde9-ca61-266d-2185-7664c1bade68@redhat.com>
Date: Mon, 21 Oct 2024 14:55:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017200132.21946-1-mvetter@suse.com>
 <20241017200132.21946-2-mvetter@suse.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v5 1/3] selftests: livepatch: rename KLP_SYSFS_DIR to
 SYSFS_KLP_DIR
In-Reply-To: <20241017200132.21946-2-mvetter@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 16:01, Michael Vetter wrote:
> @@ -246,12 +246,12 @@ function unload_lp() {
>  function disable_lp() {
>  	local mod="$1"
>  
> -	log "% echo 0 > /sys/kernel/livepatch/$mod/enabled"
> -	echo 0 > /sys/kernel/livepatch/"$mod"/enabled
> +	log "% echo 0 > $SYSFS_KLP_DIR/$mod/enabled"
> +	echo 0 > "$SYSFS_KLP_DIR"/mod"/enabled

Nit: syntax error here, should be (quotation fix and $mod is a variable):

  echo 0 > "$SYSFS_KLP_DIR/$mod/enabled"

With that, the test works for me.

-- 
Joe


