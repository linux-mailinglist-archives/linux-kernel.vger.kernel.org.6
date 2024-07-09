Return-Path: <linux-kernel+bounces-245831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A819B92BA0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6325B285FD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150C15A86D;
	Tue,  9 Jul 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobcopeland-com.20230601.gappssmtp.com header.i=@bobcopeland-com.20230601.gappssmtp.com header.b="nbP4nbM2"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8314884D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529845; cv=none; b=IUZSyjNyogkw9/t+zdGDpne+Gm1/d/K/vXdBXNj6Vuxh2z7iulbrx8Ag/0s5a7oTzzQpB6dSYbJTx7AdKwFCWH2DzLHXTEBSbR8oH+e2lyGjtb1XvSecxpdaygMCmApkrWwWiyKAbkpvbOyXutm36sRA/j9FHQA73QkGOtCnvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529845; c=relaxed/simple;
	bh=QpUypNmZPYX6Qbn7uWrc6CdR4syuflqylIr72s/KRoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A50zYNJPxGpaILaxemVAeqNkibbCNU1IoCy+rkLIRSHXrTWT3GlM9nBcKvfnOcyzFVeQwXluqrBI3CAvfFIEOdg1vGRxT5A1ZKDT6/z6KbFI56ZSn/TcDVsd7yakaizJHCtm5HoUy0hzN4+H3do06+wB6Ivk0xHgti+9aFhQMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bobcopeland.com; spf=none smtp.mailfrom=bobcopeland.com; dkim=pass (2048-bit key) header.d=bobcopeland-com.20230601.gappssmtp.com header.i=@bobcopeland-com.20230601.gappssmtp.com header.b=nbP4nbM2; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bobcopeland.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bobcopeland.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7fd19c0df0bso70959139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20230601.gappssmtp.com; s=20230601; t=1720529843; x=1721134643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=igwodF2pP24Eo7ZBJCb6M9YnHZCdb55VwSY9TgAsdaI=;
        b=nbP4nbM2SUMzTjPB8c3SHp3IiTa0EW307tBMzLxuzjCSukNIdzu5dAhJRqtccF/Xq/
         TfkPD9p2vrHZCgr+e0hCsIdQK+mP3GByitYpYy8aYedqeEGW8q3/Kca8eAUoUSQiIZAO
         fUfykt02wXD7LeIRLM1pfK11KD6w4jbjnDZJvcS0h6ANMFaTjhYpSRcRptTVJzHSdo8r
         OJLvIJCg7wIdOCFNZh+xfPXdv436y9c0MP+GUBzJ6poFrGa7MhpVr+LYsLs3rpwdRTFW
         lvGSdnIsj82hQp4CB9OH7Z9IrqjudqkuWne3IBMGPtuYi0wvPjcOcaxkC8aBzpLepZhP
         I0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529843; x=1721134643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igwodF2pP24Eo7ZBJCb6M9YnHZCdb55VwSY9TgAsdaI=;
        b=FndRAyEOi4Q4ZUal6CtvwR5kMvVr2IEVmNuvPCHId5MPkDar2NLc0Ja8Igx8U4RF1b
         4oogLWsQjVlOonBqi9y7BHDDwTuz2tYQH84b/cmbyYNuCZKGjj+oHrr9yZKkdLJ1KeFw
         4HEf+p77K/5XQSCqW+Z/1C9wJfBv/pO7HcdCkI9n1lDxCDTa8tQa8O+D2JfCKns863lf
         x9oN9GhX/d1HUDNzfsJqQgbfcGY7Ezz+iZDXDY0NYROjID6jHpKeiRjzr7Yi/wNRLAlF
         NARVUsK6fTB+mPlvHveoYjuiNO+WRy3vTeEX8v4QXZ7GWS+WGq/QO+78mahy0BQ+gntI
         g+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU4riW0wJWDtN6U9lg643ryMpkfWVhHQ5o4dEK9Jt2tUIcibpChLPceZE2uLoHxY6+DteAdA5Q/OVJLrVmuL55WBFbS40UXLlXk+elz
X-Gm-Message-State: AOJu0YwSLVMnKdfEtwaGE8ek5rIH7KilQ2xC0o4jOvC6NJ4XgzXvPy5e
	zKxSAO1uoWgOQN0F+5gvv7MwdbHvlwB0W4uAUylf0wiEiVkfwdnbQZxQy5De7FM=
X-Google-Smtp-Source: AGHT+IG74WLwSG64XSKj30m3vqA6fb9lNeQaD40A8AZFjCbUsirkGwLsei98IfKytn989EERJaRsLg==
X-Received: by 2002:a05:6e02:12ef:b0:375:9c21:6261 with SMTP id e9e14a558f8ab-38a57115ab6mr33419925ab.6.1720529842965;
        Tue, 09 Jul 2024 05:57:22 -0700 (PDT)
Received: from elrond.bobcopeland.com ([70.51.153.146])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c13d4c616asm26819173.141.2024.07.09.05.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:57:22 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
	id 8AD69FC0155; Tue,  9 Jul 2024 08:57:11 -0400 (EDT)
Date: Tue, 9 Jul 2024 08:57:11 -0400
From: Bob Copeland <me@bobcopeland.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: omfs: Convert comma to semicolon
Message-ID: <Zo0zp8It2JGC3kx5@bobcopeland.com>
References: <20240709065151.869737-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709065151.869737-1-nichen@iscas.ac.cn>

On Tue, Jul 09, 2024 at 02:51:51PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Oops, good catch.

Acked-by: Bob Copeland <me@bobcopeland.com>

-- 
Bob Copeland %% https://bobcopeland.com/

