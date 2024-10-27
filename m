Return-Path: <linux-kernel+bounces-383602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9829B1DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B732281AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E795F38DDB;
	Sun, 27 Oct 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1gQFzsS"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB2370;
	Sun, 27 Oct 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730036126; cv=none; b=NBr/Ax7BZk/CX30dJsOxXcEZKytuSxQ/3mejMmj65E8SeIBfySA/wh7gRoBZWxzkcyupvp2XOMvqBNm/AKLSPS+WQxHP06tNy1EsFPkceGz5KPxaCG0nE7kSWYBgkEYbuZs2/eKgZZeT9GPC2UkZ/pzjU199EUA0qtkGq18PGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730036126; c=relaxed/simple;
	bh=MXei8uQu9y1r4BBC57091KVEYwwDjCMgPkpBWBvRrrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJNzkEwiH4uEELic58iEz2yy07OZ91M9oIVfkxjNoNp6u4OGVvc99kS7VBX1w66Sbb3Dy38HDTv8hJ8dPZbEG6CIkGMOkqzQpMdZVXqwKzi774zC6cyJig6breLrZS153Qp631wui0OK+w0QH8+4t9BKID/wMnTtoQGGfAjFwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1gQFzsS; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7203c431f93so2746166b3a.1;
        Sun, 27 Oct 2024 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730036124; x=1730640924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ4B0yCTz1C52h9t9eSs+TfpkTdeGxsoHYRjw7nbq3A=;
        b=M1gQFzsSRaqirGzuAmIKr5yHqVSrEqttp9QIxZeO2XFjruqLOYy6EEisYD+GI1IGzV
         ojkVC0gMwX0PCv759tjZAgDrPjF1U+lzW+8+JobNjgPbZgOgmMz7kr8x1uMiLzdxslFC
         yt5tNjBlYoZfrJaIqYraa9eopc1PCFg4qXGCstp3YfRfcD0MdUnGhCNWELO9vlr2mDEq
         jqK7GOcxCsLzVfm7IbvU2cOom4q800DdOihttpOQTlCani9cTkrg/BJ4BEnaHTSDB4kY
         RE5+eKgN29kt+NNv/9cluWDYV+IQ0EH7OzT8bVeVglYNMsN7a1fLV51qeBJXRNby9B+w
         aTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730036124; x=1730640924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQ4B0yCTz1C52h9t9eSs+TfpkTdeGxsoHYRjw7nbq3A=;
        b=knU5tUhcsXWiRKTUyKepUqtckXWkwZaiE3WOvDNHYVnXpg/Sr+fwF7TnUvXYjYwB2v
         vek/TWwcj1oXsc3gkR1BrJeE1Q2mWeF5Oe8ykKXrguhpSghiOfI4MwAk6+T0X91eCgvi
         KGZxj47JslG3ZPuxw/v0+cyN8XO3c4ca1SJp8VS+zEwWdXkUj5EXvv0TrYG2HPLrN5sW
         xSjrkm+U/42/5kMhYsbJALH5DRR1kxxP+TPE6klmESpwUpcdZfQV2rhrLcjzQ1vkRqpD
         Mh4nJZlerSCyvQvx76p0P37KjPsJ4a7n9UmIzfacE8BSVTqGyBssZUQznUYuLSRRPjcv
         2e9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0pmKsM+gai5zmS/+xgneWStt/QDch4JJ6c+78bR1GeLGgzAqTKAVnlBzFQoILdszbeArSMFhJFKg=@vger.kernel.org, AJvYcCXiretBhgIV1TgvtQhUCeb3dQnGh+UFXjV5jSbDkvqftESoWjf1EO4BsPqKoVie8X2ukFL+lLIl4p2enMSO@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnv10cADbZOW9L4mYpVtstNZf7ZS7oUqNJJRNFcabc7g2Beqp
	AV8hQ0RKZGZGR5BztLen6l+0wuumPFoOUXEyNXj1K9+M2IQDwKu/Z0QS2tgq
X-Google-Smtp-Source: AGHT+IHm7D0bMRKb+u/k3Hli8PIXaPXScDJUFxksYsUKV4RdCnH9ZxFjkYeh6FgUo26Cot30VXbOxg==
X-Received: by 2002:a05:6a21:e93:b0:1d9:6e43:58c0 with SMTP id adf61e73a8af0-1d9a81d5da4mr6578775637.0.1730036123634;
        Sun, 27 Oct 2024 06:35:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866adc2sm4116740a12.18.2024.10.27.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 06:35:23 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: corbet@lwn.net
Cc: alexs@kernel.org,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mudongliangabcd@gmail.com,
	qiu.yutan@zte.com.cn,
	seakeel@gmail.com,
	si.yanteng@linux.dev,
	tu.qiang35@zte.com.cn,
	wang.yaxin@zte.com.cn,
	xu.xin16@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux-next v8] Docs/zh_CN: Translate physical_memory.rst to Simplified Chinese
Date: Sun, 27 Oct 2024 13:35:18 +0000
Message-Id: <20241027133518.2972180-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87ldyc1g3o.fsf@trenco.lwn.net>
References: <87ldyc1g3o.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > From: Yaxin Wang <wang.yaxin@zte.com.cn>
> >
> > This patch translates the "physical_memory.rst" document into
> > Simplified Chinese to improve accessibility for Chinese-speaking
> > developers and users.
> >
> > The translation was done with attention to technical accuracy
> > and readability, ensuring that the document remains informative
> > and useful in its translated form.
> >
> > Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
> >
> > Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> > Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> > Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> 
> One does not normally put a Reviewed-by tag on one's own patches, so now
> I am confused.  What is the role of you and Jiang Kung in the
> presentation of this patch?
> 

 Let me explain that, it's because of our company email permission policy,
 The author of this patch, Yaxin, has no permission to send out the patch
 temporarily. So I'm just helping to send it on their behalf. and at the same time,
 I'm a just reviewer, not the owner of this patch.

 Thanks.

> Thanks,

