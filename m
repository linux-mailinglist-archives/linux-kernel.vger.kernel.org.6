Return-Path: <linux-kernel+bounces-547150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCFAA50379
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A1B16A110
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AF24F5A6;
	Wed,  5 Mar 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MoA5xs0p"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0324EA91
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188585; cv=none; b=UtKwaWFkjW2OlyCRml9SGaJprKFbQsNVHeLXuaR/RYLgTTfJ8a/1RmXBw5njNTp4e/kfTTMLfqckJB1R77DUtEw09E93MM3zRmrHZM7dwsIWfz011yKeNpV9yvqMNYpgYGCYjorJiW+RsXe2KZOS9QVFS3EfJtIfwLSgnabsWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188585; c=relaxed/simple;
	bh=ia/vjAL7X8fJ4nhg0DN9VuRCOBMtpAkeQSqGFInxi5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDBEbNlUm/kn0DkCg3zibLZxfUhSX1OzjVStgJjEvwCTBUEgn9sjix+mns4Nfo/UdlKqovi1m7op/FCdAjemY0SF6CfkFzeWRO9DQxlrpq1qQKI0U0Buur9ZyVi3kD32JJlBbRthUos+t5/7mmZFYh6V0ofwBWYKqRCpZX4BqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MoA5xs0p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22359001f1aso160262795ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741188583; x=1741793383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJupkM+49yv8MwK8wcb6WNoJ1NpGq4LlpEvaQpfLjVU=;
        b=MoA5xs0pwfmmixixhkvDb4rt53KmUj8HJ4kqJQKyWL1DLzkNKOQyMIUxpWKKl21Dzp
         ENh9P9u1P/JrMKRdXABmYcRbDTWYW4c63jHywNHtu6JVJyETXeT3inI5+XAjUoC6MCNW
         nNUBVOFnEa+GfjkESlaTD9soJE2UlmCxiQfWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188583; x=1741793383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJupkM+49yv8MwK8wcb6WNoJ1NpGq4LlpEvaQpfLjVU=;
        b=M1t7OXdMBzIqnyRUFnYCNm+itKc06E23XyC04+zrxkzpGgPPNyC9t3bpmpgYCEUgvm
         s9KnX/4MGNlEc0K10kFv1XbP9Wd2D0vmiINdGwrC6RCENldMuJTszGb0hwITuUsjVPuT
         iAq0exhpbPb+q+8ASeTWDtsWGXSqqY/RPIOq1iVzvcyDTMGZKdMzZWp4VPGlziUruJGw
         mSFNpLrqQelJ6W949Z4sVMLhgpX7Hk+jU53ic3Z2c5H+iAInRawBE41ra4WOdopeWFaW
         dNJHv1/eaIu0e6w/fzgJrMvz+BGBSMDlCFbHkPfU9bI71peuqzf543W1VCCVUaZ8ZPib
         J1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWg41VxuELjbQ6rlhww3eguA1HtAL7GA3YcwpPoSJjKtplGi2g9Pn+8ZtaImYMgTlmhTtryQVBA35J8qFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxs00FL88taUndiUzQupo8tkS90NrtQmBoZknk6Uylj1sCVmgO
	ei7Urdg6ty11PNiZaXjSAll7jxOYjogEJoaqniuQQTOmhstyAUinQe22z7ONTA==
X-Gm-Gg: ASbGncsA9FwLMG8nT6AxVnc29eYLkoQMvhL+OukqrxS+5Ow7HaLirMmiQNTI7ywhI9P
	xHlslIKLFHQH5aM/9vi2mUb1MFeixtQlZ+xYTtaYYnhMbcfTY7O/DKDE/QCn00yss/n7J8191/z
	ny7aXBD2Sf1yd1su4hwXSQ/7voOPEgstjsWqLKrnLo7whRrAyjhSq0t1/wmH/qALRQO7fR2LzFl
	wvD64BtqvclmdDI/4qLJJpBL6C7NPQnl0NnqDV8nkgdOMRwvtLHjAGp24CKUzhlHTrK1IoitN0v
	b4flEnQCtAik9BXwUXJuFZS9TlBau4VRQooKWKhkUuW+EKE=
X-Google-Smtp-Source: AGHT+IHlNaCE6Hu5QstTVt76LsHlgPtKPgJoDodoeCDDsIrWsN0DOA2kft0VN0kYtpvgulqgypLrVw==
X-Received: by 2002:a17:902:dacc:b0:223:501c:7581 with SMTP id d9443c01a7336-223f1c985d6mr55423855ad.16.1741188582954;
        Wed, 05 Mar 2025 07:29:42 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5a4:b795:7bd9:7ab7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c596esm114569435ad.152.2025.03.05.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:29:42 -0800 (PST)
Date: Thu, 6 Mar 2025 00:29:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: ffhgfv <744439878@qq.com>
Cc: minchan <minchan@kernel.org>, senozhatsky <senozhatsky@chromium.org>, 
	akpm <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel bug found and suggestions for fixing it
Message-ID: <hom2of3ookiuoizx6r6ye3fixnhimcl7kxpqk6kebhyzul2hmk@3h3nkrvpfddo>
References: <tencent_6BF1F231EF7277B8B3EDF3999FC8CCB53B09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6BF1F231EF7277B8B3EDF3999FC8CCB53B09@qq.com>

On (25/03/05 09:49), ffhgfv wrote:
> Hello, I found a bug titled "  BUG: corrupted list in fix_fullness_group "
> with modified syzkaller in the lasted upstream related to  ZSMALLOC.
[..]
> static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
> {
> 	int newfg;
> 
> 	newfg = get_fullness_group(class, zspage);
> 	if (newfg == zspage-&gt;fullness)
> 		goto out;
> ++  spin_lock(&amp;class-&gt;lock);
> 	remove_zspage(class, zspage);
> 	insert_zspage(class, zspage, newfg);
> ++  spin_unlock(&amp;class-&gt;lock);
> out:
> 	return newfg;
> }

fix_fullness_group() is *always* called under class->lock.
zs_malloc() calls it under class->lock, so does  zs_free().

