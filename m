Return-Path: <linux-kernel+bounces-558630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270CA5E8CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F49C189EB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87181F561B;
	Wed, 12 Mar 2025 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Evv093QN"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD61F3BB5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823503; cv=none; b=WidXf40ms4J9Gl7P6EUxvHmd9uxFjBPTPiFqcafGGYGRoZPqkWRxC+qmgWAjlR/4h/qet1N0IO7jE/L7z6z83b2NlsL3qUxvBvVzBVrkYz1H1AA7+kt4g7/2+ybf7Qf7ePgaK6yd/RW55GiM9OP4ayk72UxMJpuaA7+jCQ7Bgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823503; c=relaxed/simple;
	bh=OqK4+EI0TbzhbvaQRc8UpdLTwB+tY8fTMAJuj3Y4hzo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ezRC/AAZ4vc0dTyG0h9bBpFqSrBRyuOJTDZrTBCXsCkj/FVM2iwQY0jMSO4NmQ3N8Y/1q7ihDsbJPpP71Ry4oLO4Ftjec7MSmMmJE0pq6gidFeWaGjQFPcS/v/oMni6RgXxLnVJuzamTPi/mKz+gaQA+uPDySlqdxd1ud4blACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Evv093QN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so4684636d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823499; x=1742428299; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxlYmbTsB88Ix/oaEHJZoio3VHyIr3ksQERJyVTw4bA=;
        b=Evv093QNcDQqsE7ZwfMOQOk6wQ6pnItsC2+RyPv/F4HzhGynZsQ1YtMlLPr0+N8JKZ
         rU7ZbRX18N581teTBS4FH3XX8h7MBIB0mBNyGlacJCgacGuTxgMmUJYlAop8g6Z+X1w8
         SIb2iQPv2VG90GhLQPS0pktyCIQAzFPb37ZZjTnpdN7piLU6PFLkXKLNM4sWrewX1kpc
         fB1K9woFBrzsQhuqElTwMdiwrstFgwmixCGaiFQz7j6++BIv4WToynCoa3ECaQVuXoov
         f/p6dxMc6+vHr0UIbAKYJp84wW3mSWVgX7UX6QA1AVM6ZhUk79j4EU4KG9BNanaM6LMw
         v+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823499; x=1742428299;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HxlYmbTsB88Ix/oaEHJZoio3VHyIr3ksQERJyVTw4bA=;
        b=YVjxsrmhdcWZXWpPbzZUpwFc7duM0ewnfkuKDC4mSw9Pa9ccVTqhEPGvUw+tLMYXs3
         TIYOfSx+c1d7LPicwj7WqCVd/HVev603yJGMBBOIWGkKR6syHWYL2/x5zPBzmlyZIDy5
         ELeMC2o1Km8Agz8rFuUH5MBiswOWHavOYt/A7lLf7RbgPxtmtDwUE+qR66T9WLPgtR+N
         fIGsdc2L6Kjs3bYGBd64nNpO0xC+Ef1L29lTWolKTvcXcv3aHxwAn/rB0KRbCuO3Aevg
         19IWOywi3LvJFlJYEzXZ9NXy69nBO5/jGSaepuM5LtnB4BuONWDr25vrz1KOBYM9zDBs
         grIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSDQdUWdFqcdCfKQdTmeECMJjovv0zadhPbINjyKj9bYFiJm7B3K700HhNwebzLhOZ9XFe2tchFUlRa8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JcdouICO49wTn2/TLJg+nwd0WJOt0AzNIQzivEvkyuCzcUj7
	ZOe/YLRkf7n9VSjbHVO4qhXn058ZaB6SJWv42OfQkjew5AyDzNQYkaV8K0DqCXBGCo6K/55X/14
	=
X-Gm-Gg: ASbGncursOg9ngOvlEAmoGxt2mELoFagI4HN2aJch6UVkNVrQkrQoHNYciJKFKuOsHF
	SJi/VAP6akGOWY0CPnRqwDjL7RMY/x+8lkBttZizi8QUK4WBxJWabEBMBG3eRqPj7WUGsc5ji7H
	dETd4eBzz1SbI+KSSGebZcBL4T/qCDv/yg7ibM1SajwAUnjKNNrc7LYA9a9J4/wyrdBUJYhXaeJ
	IbTiXgOoOUySSxcIwJaXJOXg474NtpUtVhvoF0mn+zVClftP5NBv+bXZa3V0HLmrVGxlvHtfvb1
	r+TMBfqP9+kBE544S70OGL2yrKFTDjUU2c+M/t8nUdCFq0oRGCruLWcUA2X1qIqc+GWb61LRiSq
	Af18RjF/ZaIE8CQ==
X-Google-Smtp-Source: AGHT+IFlyR/GAqSTyYhAIKsmF0zsCtOyT1xvl6rvyoCreNYLYVbRsQ3f/WRhdPpglFjVH6KtCvTPRw==
X-Received: by 2002:a05:6214:c83:b0:6e8:f0f8:67f7 with SMTP id 6a1803df08f44-6e9005f7742mr372102726d6.16.1741823499484;
        Wed, 12 Mar 2025 16:51:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade236776sm1858186d6.49.2025.03.12.16.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:39 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:38 -0400
Message-ID: <f64ab132bdc436ec70ded81f83324f15@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Audit: Add record for multiple object contexts
References: <20250307183701.16970-7-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-7-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1424) record is:
> 
>     type=MAC_OBJ_CONTEXTS[1424]
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  7 ++++-
>  include/linux/lsm_hooks.h  |  3 +++
>  include/linux/security.h   |  1 +
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 53 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 45 ++++++++------------------------
>  security/security.c        |  3 +++
>  security/selinux/hooks.c   |  1 +
>  security/smack/smack_lsm.c |  1 +
>  9 files changed, 79 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index ee3e2ce70c45..0b17acf459f2 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -186,8 +186,10 @@ extern void		    audit_log_path_denied(int type,
>  						  const char *operation);
>  extern void		    audit_log_lost(const char *message);
>  
> +extern int audit_log_object_context(struct audit_buffer *ab,
> +				    struct lsm_prop *prop);

Less is more, "audit_log_obj_ctx()" to match "audit_log_subj_ctx()".

>  extern int audit_log_subject_context(struct audit_buffer *ab,
> -				     struct lsm_prop *blob);
> +				     struct lsm_prop *prop);

Do that back in patch 5/6 please.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index f0c1f0c0b250..054776f29327 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1116,7 +1116,6 @@ static int is_audit_feature_set(int i)
>  	return af.features & AUDIT_FEATURE_TO_MASK(i);
>  }
>  
> -
>  static int audit_get_feature(struct sk_buff *skb)
>  {
>  	u32 seq;
> @@ -2302,6 +2301,58 @@ int audit_log_task_context(struct audit_buffer *ab)
>  }
>  EXPORT_SYMBOL(audit_log_task_context);
>  
> +int audit_log_object_context(struct audit_buffer *ab, struct lsm_prop *prop)
> +{
> +	int i;
> +	int rc;
> +	int error = 0;
> +	char *space = "";
> +	struct lsm_context context;
> +
> +	if (lsm_objctx_cnt < 2) {
> +		error = security_lsmprop_to_secctx(prop, &context,
> +						   LSM_ID_UNDEF);
> +		if (error < 0) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return error;
> +		}
> +		audit_log_format(ab, " obj=%s", context.context);
> +		security_release_secctx(&context);
> +		return 0;
> +	}
> +	audit_log_format(ab, " obj=?");
> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
> +	if (error)
> +		goto error_path;
> +
> +	for (i = 0; i < lsm_active_cnt; i++) {
> +		if (!lsm_idlist[i]->objctx)
> +			continue;
> +		rc = security_lsmprop_to_secctx(prop, &context,
> +						lsm_idlist[i]->id);
> +		if (rc < 0) {
> +			audit_log_format(ab, "%sobj_%s=?", space,
> +					 lsm_idlist[i]->name);
> +			if (rc != -EINVAL)
> +				audit_panic("error in audit_log_object_context");
> +			error = rc;
> +		} else {
> +			audit_log_format(ab, "%sobj_%s=%s", space,
> +					 lsm_idlist[i]->name, context.context);
> +			security_release_secctx(&context);
> +		}
> +		space = " ";
> +	}
> +
> +	audit_buffer_aux_end(ab);
> +	return error;
> +
> +error_path:
> +	audit_panic("error in audit_log_object_context");
> +	return error;
> +}

Let's follow the same code pattern as suggested for the subject.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d98ce7097a2d..82470862ea81 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1780,15 +1756,16 @@ static void audit_log_exit(void)
>  						  axs->target_sessionid[i],
>  						  &axs->target_ref[i],
>  						  axs->target_comm[i]))
> -				call_panic = 1;
> +			call_panic = 1;
>  	}
>  
>  	if (context->target_pid &&
>  	    audit_log_pid_context(context, context->target_pid,
>  				  context->target_auid, context->target_uid,
>  				  context->target_sessionid,
> -				  &context->target_ref, context->target_comm))
> -			call_panic = 1;
> +				  &context->target_ref,
> +				  context->target_comm))
> +		call_panic = 1;

Thank you for both of the indent fixes above.

--
paul-moore.com

