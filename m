Return-Path: <linux-kernel+bounces-298575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D995C8FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCF61C21735
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8614A4FF;
	Fri, 23 Aug 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXcRcxHx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672C14A098
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404483; cv=none; b=sT+8X98YznbnTAdGPIJddek3qB7Y4DMLK2efFbhnOrqNfg1E4OxgETdlWWKr8HEvxk1s9qaEH647ohDemMoZfZVtTKzOb8jU+A2MIIC4Ja2j/naJyXnD+29ZIEr4IBjxgE95v7YbOMddmKIh53dHY7umEodPi+SXu+8DDuuRaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404483; c=relaxed/simple;
	bh=DpdFzot5d+cGGyAY0hWeDBG62Lhmfqm8CiUU93rDlpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muqX05l/OEinyhcbvS3kCftQzICWmHGq/qvr7NDsELNb7dcU5KMgKfI8hlZn4YQGnEiL3d2LnD70f+fVP3sdSGH9j5mNlbya1lP9spJMJDAoybYLJzp/SnCChuV/K9kJBzE0uMBEaQNJKxvZjXqrNOuYzNe7jEVO5nLNGFKHbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXcRcxHx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so253637966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724404480; x=1725009280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpdFzot5d+cGGyAY0hWeDBG62Lhmfqm8CiUU93rDlpc=;
        b=fXcRcxHx4QnVRMyiHj9g6xSyoDAB9eYsc/wMyp0vzXPe6B0xloP43/h5F6NTzGJSdS
         PFJwBfcco6+vVzj8i84ojgi4sadwpn/JDf7we6B8wR3XSQ+a+YL5D9/kolzshn1IwBzi
         R2xZRZnsNveeP+EyCNjXXHQnip8FeHsAT8xqG194LjI+toASXSBqQCP5ITBg2Qdu7iZJ
         qIn6jORnhXMvw9Uy3Er5KY+UYVQcLtSUQ63uD2/XnShLUVlER1pTodFAJEhWTpi4cRCF
         bbyFrWZWa+gqR94a/D3eMRzF6+galumFPbf9ymHNQjVAuk9Am1g7vkBmOsXO53BUjme+
         Oyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724404480; x=1725009280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpdFzot5d+cGGyAY0hWeDBG62Lhmfqm8CiUU93rDlpc=;
        b=IJh3hD4TVjMYNDk7qCeBBw7YIq6lFUg3pX0qGAc+veeX9gzHu9rbit+ShOuMQhf4uL
         DBiml7U6Zclg0tz4TGdV3fwnS9bF/33+Q4ZnlQrkjsSWXXyJdwRP17FNDnySrTqKt0DQ
         L6T5U6HXDbO4ZsswcccLoP3GeL7ejX34KA/Kyb8lVF83KFthHZv22eB/sjsOlrDA6yfq
         KlRl8au9Ntl7qO9TCpLDVFYLbhwFysbwz7NOGjKxZ9kS7IgDqb2GjD8WKyk7uwP3QmWc
         lixZPAFQt5whf9DiiiA96mdwoJ3mfMb+Ff4FTAUTELYZFMjhJSh7n2kZeZqLcNNM6bsX
         BjEg==
X-Forwarded-Encrypted: i=1; AJvYcCVPeDTpygPqvzLRIMYDbRgz+73OfeQh+lr+0adgYtrbi54V0uYRpWoiRBW85ENPSh/Qbbm+VCjGqvrEcy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWBdzk97TrS4Agmh/OLXx6odvxAlZ2fXgpCyFxqXnVEYjVIdP
	tf4HSj+YCX0AvzyCwMIYl2JkfmQWsjCcYc8wbWWKfcolYfY9FGoxbnwj9IcB22I=
X-Google-Smtp-Source: AGHT+IGlqxi82bqE5OnH6pUfVDSjZmo6v1W+GCxA/gKgnbaRP3a8TTRkePXC4eVP/bVHATnXBfckwg==
X-Received: by 2002:a17:906:c105:b0:a80:f79a:10c9 with SMTP id a640c23a62f3a-a86a518ae6amr121376366b.12.1724404480017;
        Fri, 23 Aug 2024 02:14:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220e76sm231727266b.40.2024.08.23.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:14:39 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:14:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: benjamin.berg@intel.com, daniel.gabay@intel.com,
	johannes.berg@intel.com, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com
Subject: Re: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_alloc_sta_after_restart()
Message-ID: <f7dda0b3-9d58-4f1c-8f16-94c1aee8af4d@stanley.mountain>
References: <575625da-60bc-4444-a5f3-a7acf925f1e5@suswa.mountain>
 <20240823030423.1781977-1-make24@iscas.ac.cn>
 <3a9fc675-9c39-47e1-8735-a9d107b4d0be@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9fc675-9c39-47e1-8735-a9d107b4d0be@stanley.mountain>

It would have been nice to know what Gregory's thoughts were about this code but
he left Intel in Jan.

regards,
dan carpenter


