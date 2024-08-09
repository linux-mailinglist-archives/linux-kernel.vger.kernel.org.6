Return-Path: <linux-kernel+bounces-281400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C694D67D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDD21F21EEB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F415FCEA;
	Fri,  9 Aug 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAl3UGdo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3ED14B96C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228942; cv=none; b=RUJGMJRHShTtkbZGy4EGu5IrDE8lCzW1OSjT8AuvuR5yLoP5iJFx8JyA9WsXFdl8QR43pGM6two584fyG1xoyYTRcJW+2plqapn1da0VCUa+rfR5gvD5vh7BzYbUXD7+iiY7GXDNIrzRqAr5ZDVB3p78OeY4pM5kK/ew8yAiFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228942; c=relaxed/simple;
	bh=o3gI+eWBz9OdExdT/y37sLpjS+ho3xXPI1CduZtOCuo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fr2b9/RAPoFhq+Yk0QFjNvGI2f7Jto8OOyYMKoRdDk89lFCM/AACDJUed24YFkOkP9JsSOj+dGcNxiqFbp9EnJHOpEd4sjTNxXOJ06JH6XyfFsYoXSksY+24Mas11qwdavF+gwuZBL6505lphVrr4cNpCxWS7rLcSifA0VZlnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAl3UGdo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723228938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTmJUzIYH5xdCwgnyXYAGeRQ3EOacpMfgAoosgsxAQU=;
	b=EAl3UGdoVzbKPU4Kd0qVBHEozF6ZdJ8gceN85knxz3Pr2w9lA+fOgiRIypr2AGunMpy3ZM
	8tK91tMMK4agViOk7TYU9tc70Vj+0w3BCysOIRvLZnzzS9fyoz3PZBdz3sh9R4Yr1+oEof
	2Ec/HXCTYipctWx+kQHHQmVqk7t+j9g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-_zwYSFm8OmCzxH2I0QfCig-1; Fri, 09 Aug 2024 14:42:17 -0400
X-MC-Unique: _zwYSFm8OmCzxH2I0QfCig-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1de7141f1so280299585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228937; x=1723833737;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTmJUzIYH5xdCwgnyXYAGeRQ3EOacpMfgAoosgsxAQU=;
        b=khzOpcjOJwBaNtEI8gaq7Xc9rmk09Anya2JogiEC7UI5w8L8FsBh7WrTQTguLxbz2E
         DkXIHl+FfW0D85VWQI5DNcsr7MfUTlVBTjf6/6nCZK6xXzCdhr7ThNtHJ9nBx+VEcA7W
         DO0S+l6YOoQwMopcmH3QFUAeBTIFw0eZKSQApH+v3bDBjfuCG3pwDNPIKW/CKltbqKsM
         aVwV9s56KZ6Lhu42KVvIu7X6AVi4HJx1hYuZOC/zNxwK3hHBTIiwbwH9qqeV/liTKqou
         7R2R+ZTGDT0oytK8fa0NulVAZk96QYa/hXXDFMMr+fExyr/bqQKb67QJCBWkgDSU9KN6
         rjUg==
X-Forwarded-Encrypted: i=1; AJvYcCUCTHvAb35ee/ws4stlZ0TByF9s3Fea2BfIRKvMpHXzMcPFi+vBCD2lbzjhUgtalfQO8dN28U3fFayRqU1YtbAFzes3j8fqt4AZXVCG
X-Gm-Message-State: AOJu0YyI1tbTJTERUTG8s2w/pELI3gdGSN4ysLWdP/T80NtHjeDrECLX
	VmM2uImv4BY7C69YHnTc+r11nIa2xhUv9/2Wt8JqQXXmFWfG2x0JqhekA/SzfmD/YzMZD5GqsBL
	Wx+SPjJ11uiESBChpnHS9fbYrBb7fLh+g7dA3WFUt6zpcCxzhFbvhBQMty2zFEg==
X-Received: by 2002:a05:620a:24d6:b0:7a1:e001:bb1b with SMTP id af79cd13be357-7a4c18c2d1bmr260014585a.60.1723228936977;
        Fri, 09 Aug 2024 11:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXXXCv7azVX3+7vSHxmPbJNeW7P2HuAh5Ji2ZQSlJNOIDr1NBkSTa19JwsluzgDU1JZcECjw==
X-Received: by 2002:a05:620a:24d6:b0:7a1:e001:bb1b with SMTP id af79cd13be357-7a4c18c2d1bmr260012185a.60.1723228936553;
        Fri, 09 Aug 2024 11:42:16 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d7a531sm4115085a.58.2024.08.09.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:42:16 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:42:13 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Dan Carpenter <dan.carpenter@linaro.org>, 
    Daniel Bristot de Oliveira <bristot@kernel.org>, 
    "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
    Clark Williams <williams@redhat.com>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtla/osnoise: prevent NULL dereference in error
 handling
In-Reply-To: <20240809140545.698f654e@gandalf.local.home>
Message-ID: <25b597bd-bdc4-411f-e5d9-78ed4d042c4b@redhat.com>
References: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain> <c73c51ae-99da-793a-6dcb-2fbc6871261d@redhat.com> <20240809134133.751723e5@gandalf.local.home> <7ece353a-36a6-6154-97d9-b255728b9807@redhat.com>
 <20240809140545.698f654e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 9 Aug 2024, Steven Rostedt wrote:

> On Fri, 9 Aug 2024 13:53:33 -0400 (EDT)
> John Kacur <jkacur@redhat.com> wrote:
> 
> 
> > > > Although your fix appears to be correct, I wonder if it would be better to 
> > > > create a second error label, such as out_destroy_tool: as described in 
> > > > section 7 of the coding-style.rst
> > > >   
> > > 
> > > There's no reason for that. It's the only error path. That is, nothing
> > > would jump to the original out_err:
> > > 
> > > And for a single error, an if statement is good enough.
> > > 
> > > -- Steve
> > > 
> > >   
> > 
> > Ah, right of course.
> > Okay in that case, Signed-off-by: John Kacur <jkacur@redhat.com>
> > (applied the patch, built and ran)
> 
> Note, "Signed-off-by" is for the author of a patch or someone pushing it
> through their tree. I believe you want either "Acked-by" or "Reviewed-by",
> and since you ran it you could also add "Tested-by".
> 
> -- Steve

Thanks Steve,

Reviewed-by: John Kacur <jkacur@redhat.com>
Tested-by: John Kacur <jkacur@redhat.com>


