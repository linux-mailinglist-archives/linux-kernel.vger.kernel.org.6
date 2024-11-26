Return-Path: <linux-kernel+bounces-422720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6D9D9D70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE841163FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814BA1DE3C6;
	Tue, 26 Nov 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP44LUSW"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8E1DE2B3;
	Tue, 26 Nov 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646049; cv=none; b=EvbV9y2JXU8uUQwmtyKbVMWsvJO+JrEPX1L28qQN0++Md/qyGu7io5luQ9vFom+1RGalJb/ZGFnPbJE3oJIN1AD3usG69t99NM406YOIT60BO/vi12/GEfe/kNnJPKkWy6mO2WHNf/W0rObGpg+bNVclAtGbC5mxBggXuqjJ+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646049; c=relaxed/simple;
	bh=B5ZdijXHGTf9/VBMxXk0sgaeGJSHANk1xhdrCGF3VVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcXBG+IBMWDGFCMaEI4biJreigbvkNITPfOQmxrXvQ9x6EEAvGbh/A872Y71qL1lnxs/jvPa1vPhrdmytJxB7NAL0v8l3X0chkO47ltumkxbceytd0huMJIUxNpie3yIryOo3DBS/u04CgEN+uPLhrCJyWxIlC4ftAVtl/pjMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP44LUSW; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e382589e8fdso5807556276.0;
        Tue, 26 Nov 2024 10:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732646047; x=1733250847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B5ZdijXHGTf9/VBMxXk0sgaeGJSHANk1xhdrCGF3VVs=;
        b=aP44LUSWZZz4wd59KY9A4CpeISbNFLShnxxJ2+d7IXSE1Jad0TcLa6F7Qq+nXTqXyw
         9dO+E97SwAbciwKB1VPHb/txg4DfHrzXcoIhO9fCjG/VoIEAQJ8GCpjuLtAXJz3eeu0y
         ubzXqX4DOmJHb8+3QKan8zi9t0SLhrFP+8LGNPFeCMqOUWgJ+t0OJD34M8Olsi7GtpyW
         i0baWMgAevZE7PChKwsr1rhYoXfoYQ/KlnzB+4hQbjEIBdLPHL13PJtmZI34nrlPPKvE
         ku8gWz0JwXwWxlHcOySD2tPf5m5XsAInrqtpy8iawvkt5nf99un4tXtk3bocSjXR4w5l
         dfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646047; x=1733250847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5ZdijXHGTf9/VBMxXk0sgaeGJSHANk1xhdrCGF3VVs=;
        b=LBpM/WMFaLyh1dMp7cjvdbuMsgIhXje5BGrMP44VcNW5NVe8cE6Tuu8ULQT5/NdwEU
         /0IZAjXJEesPZmlRSv2owp7BUetuQbRBJ5+/OmLeRjI7FhsoLkG5BUWF6LYgRYwrEPzD
         r+P5MTvkkTO+xpKgoXMZd3w85Ge1ZkDjUr3ZB96zxqEgbHBjsE0HBNCtOlEztkpJc3Nc
         fSoJDfRz9mlNQEQw/Z+BYXlr4LJ8EVOYYf70CSubSxYu33OEBPPhNzh9vHCvkvplhABX
         mKjPScJIk0SnnkxF7730D1GJp0jNyBzafkZovfTssyZVH0EACxM5eklJbH+gyAYdooKd
         GRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBU1tNQdluJP+GUx9gQ8yNSaw33gHOYlCglIsWs48DQnldLxaL2rnhMZKixAlNy9PIeOhSGGgOeuIy@vger.kernel.org, AJvYcCVSMBKrpVtm5cQjGvybMWHHxka4iXMQ8vSqySBmmUWwlF9st9D8SAj+FDWBEqVqQGSeCgpTKNr1rzZ6wCXN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5QM1B9Nv+v8E9kDGit6Pj6vgBSyP9vw2x3LIAKP10ZN8sChS
	4u5O8PZULsJMhT63/DJxY3S8pkDj3+tMcxm7T1KklUuxuwIm9DLJnXl8G9wpYNaUMToJrYlNdCt
	iML1sTpOhU65f3WsLjLjXHnImswY=
X-Gm-Gg: ASbGncuQztMFyzLGajx9l/Zi8AOggKLGNtw7QlnTkqdW+3ap52b5wNnt5S+pN9maimC
	wQXfit3WHP3mgJzXvpszhdfaWwJdOyGov
X-Google-Smtp-Source: AGHT+IEAKAQZoBZRcCS59s6ATzOJRqSPoDhyFrhH0wpI4a7G9pyRjoqsbwGfh6mDJveSJ2gv3edzPDtBsyPh4VazY1Y=
X-Received: by 2002:a05:6902:2606:b0:e30:e9b8:abcc with SMTP id
 3f1490d57ef6-e395b973db9mr91652276.48.1732646047430; Tue, 26 Nov 2024
 10:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-adpdrm-v2-0-c90485336c09@gmail.com> <20241126-adpdrm-v2-1-c90485336c09@gmail.com>
 <050d1398-cfc2-4921-b82a-95eecbcddba4@kernel.org>
In-Reply-To: <050d1398-cfc2-4921-b82a-95eecbcddba4@kernel.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Tue, 26 Nov 2024 19:33:56 +0100
Message-ID: <CAMT+MTRJrN1_LBm+Ba6wh1BcdG0co-AHY8t4rnLuLAV=75wZbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: Add Apple pre-DCP display
 controller bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 17:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Please take a look how other bindings define ports. You miss here
> several items and more important - description what are these ports for.

Aside from missing descriptions, this definition is copied almost verbatim from
snps,dw-mipi-dsi.
Ack on the rest of the comments, those and the descriptions will be
fixed for v3.

