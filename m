Return-Path: <linux-kernel+bounces-353409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22650992D64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD9E2843E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE71D460F;
	Mon,  7 Oct 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvJcs/b0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2E1D4353
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307917; cv=none; b=FzvFzsEukjuwna9jza1IWw/EmfLBuqrizxot+BJ5uzvxA53/Y9W+LOPMqVceHnwOs6ZeqkJDk0P3djVitm1fIuWoo1+J3dkPzbaO1D7pBf0eDtWKq3i508YGXa/rQ5mWAJY0iAzuJgXXOqzIxAT8jng7+vPPxOTEl4P8Rw64qT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307917; c=relaxed/simple;
	bh=eIMXnheLgwY5mybCt8FtGo2eFwqlzkHxp79j8QrmOaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeJvOc6sdbLjFyvlveZffQc+g/jQNscOXtRCe4fSynSgi6K86Q4GDk8uSzb68AlYBKX69YqkBtLItTObdlv7QJsUn6fBNpaiUZtHRPFwHomWQQTV/WlUx7nT3Dd8am03q3gqrNZSCZKLR7XH+8PUnK4xKsuA0EYxsK6ghFKW2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvJcs/b0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728307914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqk2iWvYlf396g8OOaJ8zXakmd0+WF8brPT7Fp5xgVg=;
	b=XvJcs/b04ALq0fL/gzl5DenGQzzJkpV5xNrG2oGibAMLowaAA+ce/OUj55m2TW017uIs3f
	U7QSG/+FloUvoUPDWsbkrVAlCe4kK66Jku3Xkm20tEywMK+cop8/MTFOxW4FFVuGXU26Yi
	4wsVFOKJlEbow+BScsPOVW+v4kHQggw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-iPYl4ztYNEi2O3IFv2rzNQ-1; Mon, 07 Oct 2024 09:31:53 -0400
X-MC-Unique: iPYl4ztYNEi2O3IFv2rzNQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so42366375ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307913; x=1728912713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqk2iWvYlf396g8OOaJ8zXakmd0+WF8brPT7Fp5xgVg=;
        b=iRDuoaB3JjAF1i65Me5Smmle3d0ZwLuC3QfM96p+fSRAB68VzuPkfl5lggB86ub65V
         fn64M8zXo7iagVzUChVwlFh/Cg2rT1YkL4G/3ibnogm1+MKtMRfNlj+MN1YkaYX8saRB
         HFjHYmrxi0zIEj9NGYlr85bfnx/v7vyusLJ8kkMsm53JCcBkCU+wtxroyajqeOYQM1Za
         x0iyJSfhsOvr1FwHx3Agrrs2aaPyKWvPhVUFDkyatuOy9rFn8tnznABO+DOftLxmtMEk
         CA7TR4sn3Yyh/Sl5EAJ86zAKgUlxRQN148BwrCxmW/WXh8fnx7k3d5Eelcn+LlrfnVdG
         MdkA==
X-Forwarded-Encrypted: i=1; AJvYcCWqQO6adSpLnvOngjTbRk3J7oVLwjr0p9n57qq8QRjm/QAhIiu489MrVvmfwGFPbDoWJwDYWecAYq/0XDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAI0EWxTeFbBNcEjB/COOnVXNbsGN4s5zGalDG22gRMyjBh65
	SHQ/rmOiaBj+TA79WNcO7HS7Bz1Sfg132iaCFfkBHUC2kHC04ci/PR4ewPAHza6GsUn1LBZCKwu
	rJgzdVpeXEL7gisrTaYwN391qeY0+DBg9vmxji/JcZKq8w+G23aNSQaBo2gTKEA==
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3a375bd2d64mr106097795ab.24.1728307912694;
        Mon, 07 Oct 2024 06:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHytcVO1FmhJ+bU2c/zU8wO91+yF3vR0ajfP57WOhlG1bZ8VjO72kOmwPr7mMBL4Ng5gE9mOQ==
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3a375bd2d64mr106097255ab.24.1728307912051;
        Mon, 07 Oct 2024 06:31:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a874e00sm13449195ab.73.2024.10.07.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:51 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:31:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
Message-ID: <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241004015937.2286459-2-lulu@redhat.com>

On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
>The vhost is now using vhost_task and working as a child of the owner thread.
>While this makes sense from containerization POV, some old userspace is
>confused, as previously vhost not 

not what?

> and so was allowed to steal cpu resources
>from outside the container. So we add the kthread API support back

Sorry, but it's not clear the reason.

I understand that we want to provide a way to bring back the previous 
behavior when we had kthreads, but why do we want that?
Do you have examples where the new mechanism is causing problems?

>
>Add a new module parameter to allow userspace to select behaviour
>between using kthread and task
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 9ac25d08f473..a4a0bc34f59b 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
> module_param(max_iotlb_entries, int, 0444);
> MODULE_PARM_DESC(max_iotlb_entries,
> 	"Maximum number of iotlb entries. (default: 2048)");
>+bool enforce_inherit_owner = true;
        ^
This should be static:

$ make -j6 O=build C=2 drivers/vhost/
...
   CHECK   ../drivers/vhost/vhost.c
../drivers/vhost/vhost.c:45:6: warning: symbol 'enforce_inherit_owner' 
was not declared. Should it be static?

>+module_param(enforce_inherit_owner, bool, 0444);
>+MODULE_PARM_DESC(enforce_inherit_owner,
>+		 "enforce vhost use vhost_task(default: Y)");

I would follow the style of the other 2 parameters:
                  "Enforce vhost use vhost_task. (default: Y)"

With a view to simplifying bisection, we added this parameter in this 
patch, but it does nothing, so IMHO we should only add it at the end of 
the series when we have all the code ready. Maybe you can just add 
`enforce_inherit_owner` here or in the first patch where you need it, 
but I'd expose it with module_param() only when we have all the pieces 
in place.

About the param name, I'm not sure "enforce" is the right word, since 
IIUC the user can still change it using the ioctl. It would seem that 
set `enforce_inherit_owner` to true, it is always forced, but instead 
ioctl allows you to change it, right?

Is it more of a default behavior?
Something like `inherit_owner_default` ?

Thanks,
Stefano


