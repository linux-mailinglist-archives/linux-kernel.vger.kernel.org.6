Return-Path: <linux-kernel+bounces-573074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D13A6D2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8459188F8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB1179BD;
	Mon, 24 Mar 2025 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N49xQGTo"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852A4C76
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742778586; cv=none; b=r9I59xxY/0FarKVj85JkuuYLUfZsMgdqHc6QcvaXR99xdyqIepIGdC6F4HrjbGlzlb1c90G5USarrdvrg003ANNR5mZAjkPsy3omLSgUqSct/rTTdZwLFqFjL6kIrzI3ZgPqPc8mUjptdj92tnnj0MZ/hKNLLFxlIeDzIaShxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742778586; c=relaxed/simple;
	bh=CAbn5Kul+JjubCYBmgXfb4uRBo4yTlHs8gAM4cJ9AMY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JzZ5V74FjRC501raha0UdJdjMMW82Mnc2m6u846db/8+vKaAnnXEUg1801FUHOj8b2mmO8un6UEJis6AL7t4Ov5NNvAl75BDhE8tVpaSF/uYM3x22CWVpjWdBgparOgp/Jpa+V8kTf9S/HxhHXCx3ADnJyzxlHvlrhl/Yjl64uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N49xQGTo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so22789095e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742778583; x=1743383383; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRfmMTiV30ALZvulcccEG+A+D/DDAsQnRZ2wT4RHUEA=;
        b=N49xQGToZ5BsKyqZ6gl5OW53Ig5A5qveOCJ2rSuBF5czmsmxArASzsBZgLrkgPVxlt
         b2N6D84JrAgMBtPNvcNVQPp7YMSz/zQ+e5rfx1tO+SBCszBuXapMlmC4vD8PQGwde5LO
         dPxXKwVCRvmjtbmqeTfZ4JTdSPCwBcUiuarwC/oeG69kcFbEvxRTzrmjcFzPGu0+RaeY
         ij3F796Iz/bZ0izlkH+3DxZGifR1x4TMXxlNBjsTAMCBATZTaS0Ebukcv9evVRF7qKiX
         OlNYsDHXfwSVbOwJNTUf7p7szfnunKygcZyXoAASPJQ+cjgfZbXGdoKxEKIGqgTmZpUj
         3sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742778583; x=1743383383;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRfmMTiV30ALZvulcccEG+A+D/DDAsQnRZ2wT4RHUEA=;
        b=C5WwZ6ajBXAp1OFvU8dQTcJssZCWceb1Z8OzDeOxliWuD7eRWERzL3Poo2r6gEdnp7
         50DdoC8/Vn/X2AEwDA8q/TVyX9wALJVYl/pysX+qr4L3PoUCPkf9VC6CYkFM2ztvE1oN
         iBgX7gY38PaEOoCQEflQXpEbSWwybs9uljXkNfHOREN29lFpOyTxRQx+XmrwLvjmrHxb
         faGn1JphTKRxP6GfbwD2hUnRhSVv7/rnC0Pf3oVn+0KZ6eYXv1cinJlIKe3PsJYkrjDB
         gJLJK0DaU/vxx9tFJNQhgKyc2k8wFG+SrROjeRiRRxLDMFbmqTRfkqL70oOCDkJjwF2Y
         JkLg==
X-Forwarded-Encrypted: i=1; AJvYcCVbogTrpG/Gi9ualB9HHN0ECkNWfg/u6FDRRyOAq4fzEyo/EXXazPF+kCNaJiEfgz1qVQJfB0P/9yN6vMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvvIYD0iU8MuxrqkAhA6uvuV+wy0wNYCqA/efcvl7ftUVm+lUt
	ssEGtvNpSzc8Q6U+fLjlCuZdZg8B1wGaUcO3E78qqZanM9KQy/OS
X-Gm-Gg: ASbGnctb88GP7IhMsKBXEuxVayPjxmhlhB7UXeGmke2oX3xowL6qNNfCW2MPxxWe0Lr
	XecSNBCjOixVrlzSGT1kdBpOeza0SyNaT861LPcJyIUrhlk3Pu4s0yB7qGrJBbUg3CzwOJgRcJn
	KmLEhcwhY+o/wuNHfX6NtibA0HW5U+Lu73jKa8yxaQ9JzxWHLcb6dF8AC8ntl/CjqoWIFojSaxV
	CgNPLYo/anCPtcorDo2V57nUJ52ku8YvmnB+jk1KFau2y5sbQXi8TayzPrsvVLEopikpTc78bA0
	IGbu5g//I2QP8hDCETpNtDvAfB0Hqs7+EvRE+DGM0+/I742ZwwY0DunF
X-Google-Smtp-Source: AGHT+IE33xEsoykBSVsygT8pa6YMbMTFPnFBBX6KpYMpIHJt+/YaaVxArWJI2HKWi/eEz9+p1SKkhA==
X-Received: by 2002:a05:600c:1989:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-43d508725ecmr92657095e9.0.1742778582519;
        Sun, 23 Mar 2025 18:09:42 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:4d4:f101:e41a:977a:f788:910f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3adc4488sm119483545e9.0.2025.03.23.18.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 18:09:42 -0700 (PDT)
Date: Mon, 24 Mar 2025 01:09:39 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dakr@kernel.org, christian.koenig@amd.com, mario.limonciello@amd.com,
	daniel@ffwll.ch, ville.syrjala@linux.intel.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	lyude@redhat.com, sumit.semwal@linaro.org,
	AMD-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] drm_connector reference counting and USB-C docks
Message-ID: <Z-Cw0x7wa5w7tliO@debian.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There is a reference couting / lifecycle issue with drm_connector when used
with a USB-C dock. The problem has been previously reproduced on both Intel and
AMD GPUs.

On both Intel and AMD, the symptoms are:

  - multiple connectors being listed in sysfs `sys/class/drm/cardX/` (because
    the old connectors are not removed when the dock is unplugged)
  - no display on the external monitors.
  - "Payload for VCPI 1 not in topology, not sending remove" error if drm.debug
    is enabled

On AMD, this issue is the root cause of a number of errors when re-plugging in
a dock:

  - *ERROR* Failed to get ACT after 3000ms
  - kernel NULL pointer dereference calling setcrtc
  - UBSAN: shift-out-of-bounds in drivers/gpu/drm/display/drm_dp_mst_topology.c
  - use-after-free in dc_stream_release
  - refcount_t: underflow; use-after-free.
  - slab-use-after-free in event_property_validate
  - WARNING display/dc/dcn21/dcn21_link_encoder.c:215 dcn21_link_encoder_acquire_phy
  - Part 1 of payload creation for DP-2 failed, skipping part 2
  - probably most bug reports relating to suspend/resume and a dock

This bug has been reproduced on both Ubuntu/Gnome and Debian/XFCE. The symptoms
are intermittent and vary (as above), but the consistent initial symptom is
multiple connectors being listed in sysfs.

To reproduce, annotate drm_dp_delayed_destroy_port with something like:

--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5014,6 +5014,9 @@ drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
 
        if (port->connector) {
                drm_connector_unregister(port->connector);
+               printk("drm_dp_delayed_destroy_port %s refcount=%d\n",
+                               port->connector->name,
+                               kref_read(&port->connector->base.refcount));
                drm_connector_put(port->connector);
        }
 
Boot laptop with dock connected, activate external monitors, suspend, unplug
the dock, and resume. This problem is intermittent, so these steps may need to
be repeated. But when the problem is hit, the drm_dp_mst_port will be
destroyed, but the drm_connector will still be alive. (This can also be
reproduced with just plugging and unplugging without suspend/resume, but, on my
laptop, it happens almost every time with suspend/resume).

The cause of this problem appears to be:

  - calling setcrtc to enable a CRTC results in the drm_connector refcount
    being incremented:
  - drm_atomic_get_connector_state appears to add connectors into
    drm_atomic_state->connectors, and increments the refcount

  - on disabling the external monitors, a call to drm_mode_setcrtc results in
    the drm_connector being destroyed via call chain:

    amdgpu_drm_ioctl
      drm_ioctl
        drm_ioctl_kernel
          drm_mode_setcrtc (via func)
            drm_atomic_helper_set_config (via crtc->funcs->set_config)
              drm_atomic_state_put
                __drm_atomic_state_free (via kref_put)
                  drm_atomic_state_clear
                    drm_atomic_state_default_clear
                      drm_connector_put
                        drm_mode_object_put
                          drm_connector_free (via ->free_cb put destroyer)
                            dm_dp_mst_connector_destroy

  - so the drm_connector is not destroyed until/if userspace calls setcrtc to
    clear the CRTC (set.num_connectors=0). If this does not happen for whatever
    reason (userspace process is terminated, frozen due to suspend, etc.) then
    the drm_connector object will still be alive even though the corresponding
    drm_dp_mst_port is dead.

  - in normal usage, drm_connector_cleanup releases the connector ID:

    ida_free(&dev->mode_config.connector_ida, connector->index);

  - when dock is replugged, a connector ID is allocated:

    connector->connector_type_id = ida_alloc_min(connector_ida, 1, GFP_KERNEL);

  - if setcrtc has not been called to free the old ID, then ida_alloc_min
    allocates a new connector ID instead of reusing the old one. This explains
    the "multiple connectors being listed in sysfs" problem.

  - the other problems occur after this, due to the multiple half-dead
    connector objects.

  - UBSAN: shift-out-of-bounds in drivers/gpu/drm/display/drm_dp_mst_topology.c:4568
    occurs because vcpi==0 in this payload, so BIT op is a left-shift by -1.

  - slab-use-after-free in event_property_validate: looks like it happens
    because hdcp_update_display, hdcp_remove_display copy references to
    amdgpu_dm_connector (which contains a nested drm_connector) in to the
    delayed_work struct hdcp_workqueue without incrementing the reference count
    (see pair of lines "hdcp_w->aconnector[conn_index] = aconnector;").
    If the connector is freed, &aconnector[conn_index] will become a dangling
    pointer. Actually, I can reproduce this easily by just booting to
    gdm then plugging and unplugging the dock a few times, so it's
    possible this is an independent issue that also needs fixing.

  - use-after-free in dc_stream_release - there appears to be a few
    points where a dc_stream_state pointer is copied without refcounting
    ("pipe_ctx->stream = stream;") but I don't know if this is the problem. It
    could also just be that earlier failures have left something in a bad state.

I'm unsure of the best approach to fix the root cause. One way is to try
and release the references by disabling the CRTC. I tried calling
drm_mode_crtc from drm_dp_delayed_destroy_port. This was a bit hacky,
but did seem to work, the reference count got reduced to 0, and the
drm_connector was destroyed. Another option would be to call the
drm_connector destructor from drm_dp_delayed_destroy_port (protected by
some mutex so that it doesn't get called twice when the actual refcount
goes to 0) - that might work to free up the connector ID, but I suspect
there could be other issues with having the drm_connector object still
alive and potentially holding references to other objects, even though
the dock has been physically disconnected.

